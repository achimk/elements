
public final class ClosureObservableNotifyStrategy<State>: ObservableNotifyStrategy<State> {
    private let closure: (State, State) -> Bool

    public init(_ closure: @escaping (State, State) -> Bool) {
        self.closure = closure
    }

    public override func shouldNotifyChange(from oldState: State, to newState: State) -> Bool {
        return closure(oldState, newState)
    }
}
