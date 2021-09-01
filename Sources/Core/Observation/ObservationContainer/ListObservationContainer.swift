import Foundation

public final class ListObservationContainer<Value>: ObservationContainer<Value> {
    private var observations: [(uuid: UUID, closure: (Value) -> ())] = []

    @discardableResult
    public override func insert(_ closure: @escaping (Value) -> ()) -> ObservableToken {
        let id = UUID()
        observations.append((id, closure))

        return ObservableToken { [weak self] in
            let index = self?.observations.firstIndex(where: { $0.uuid == id })
            if let index = index {
                self?.observations.remove(at: index)
            }
        }
    }

    public override func makeIterator() -> AnyIterator<(Value) -> ()> {
        return AnyIterator(observations.map { $0.closure }.makeIterator())
    }
}
