
public struct NonEmpty<Collection: Swift.Collection> {
    public let head: Collection.Element
    public let all: Collection

    public init?(_ rawValue: Collection) {
        guard let head = rawValue.first else { return nil }
        self.head = head
        self.all = rawValue
     }
}

extension NonEmpty: Sequence {
    public func makeIterator() -> AnyIterator<Collection.Element> {
        return AnyIterator(all.makeIterator())
    }
}

extension NonEmpty: Equatable where Collection: Equatable {
    public static func == (lhs: NonEmpty<Collection>, rhs: NonEmpty<Collection>) -> Bool {
        return lhs.all == rhs.all
    }
}

extension NonEmpty: Hashable where Collection: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(all)
    }
}
