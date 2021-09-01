
open class ObservationContainer<Value>: Sequence {

    public init() { }

    @discardableResult
    public func insert(_ closure: @escaping (Value) -> ()) -> ObservableToken {
        abstractMethod()
    }

    public func makeIterator() -> AnyIterator<(Value) -> ()> {
        abstractMethod()
    }
}

extension ObservationContainer {

    public static func set() -> ObservationContainer<Value> {
        return DictionaryObservationContainer()
    }

    public static func ordered() -> ObservationContainer<Value> {
        return ListObservationContainer()
    }
}
