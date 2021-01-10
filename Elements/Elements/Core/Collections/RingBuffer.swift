public struct RingBuffer<T> {
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public var isEmpty: Bool {
        return availableSpaceForReading == 0
    }
    
    public var isFull: Bool {
        return availableSpaceForWriting == 0
    }
    
    private var availableSpaceForReading: Int {
        return writeIndex - readIndex
    }

    private var availableSpaceForWriting: Int {
        return array.count - availableSpaceForReading
    }
    
    public init(count: Int) {
        assert(count > 0, "Number of count must be greater than 0!")
        array = [T?](repeating: nil, count: count)
    }
    
    /* Returns false if out of space. */
    @discardableResult
    public mutating func write(_ element: T) -> Bool {
        guard !isFull else { return false }
        defer {
            writeIndex += 1
        }
        array[wrapped: writeIndex] = element
        return true
    }
    
    public mutating func append(_ element: T) {
        defer {
            if (isFull) {
                readIndex += 1
            }
            writeIndex += 1
        }
        array[wrapped: writeIndex] = element
    }
    
    /* Returns nil if the buffer is empty. */
    public mutating func read() -> T? {
        guard !isEmpty else { return nil }
        defer {
            array[wrapped: readIndex] = nil
            readIndex += 1
        }
        return array[wrapped: readIndex]
    }
}

extension RingBuffer: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var index = readIndex
        return AnyIterator {
            guard index < self.writeIndex else { return nil }
            defer {
                index += 1
            }
            return self.array[wrapped: index]
        }
    }
}

private extension Array {
    subscript (wrapped index: Int) -> Element {
        get {
            return self[index % count]
        }
        set {
            self[index % count] = newValue
        }
    }
}
