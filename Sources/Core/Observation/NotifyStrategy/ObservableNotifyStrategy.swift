
open class ObservableNotifyStrategy<State> {

    public init() { }

    public func shouldNotifyChange(from oldState: State, to newState: State) -> Bool {
        abstractMethod()
    }
}

extension ObservableNotifyStrategy {

    public static func always() -> ObservableNotifyStrategy<State> {
        return ClosureObservableNotifyStrategy { (_, _) in true }
    }

    public static func never() -> ObservableNotifyStrategy<State> {
        return ClosureObservableNotifyStrategy { (_, _) in false }
    }

    public static func whenNotEqual() -> ObservableNotifyStrategy<State> where State: Equatable {
        return ClosureObservableNotifyStrategy { $0 != $1 }
    }
}
