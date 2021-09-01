
public final class DictionaryObservationContainer<Value>: ObservationContainer<Value> {
    private var observations: [UUID: (Value) -> ()] = [:]

    @discardableResult
    public override func insert(_ closure: @escaping (Value) -> ()) -> ObservableToken {
        let id = UUID()
        observations[id] = closure
        return ObservableToken { [weak self] in
            self?.observations.removeValue(forKey: id)
        }
    }

    public override func makeIterator() -> AnyIterator<(Value) -> ()> {
        return AnyIterator(observations.values.makeIterator())
    }
}

