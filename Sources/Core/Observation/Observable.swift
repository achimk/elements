import Foundation

open class Observable<State> {
    private var observations: [UUID: (State) -> ()] = [:]
    private let notifyStrategy: ObservableNotifyStrategy<State>
    public private(set) var state: State {
        didSet { notifyTransition(oldValue, to: state) }
    }

    public convenience init(initialState: State) {
        self.init(initialState: initialState, notifyStrategy: .always())
    }

    public convenience init(initialState: State) where State: Equatable {
        self.init(initialState: initialState, notifyStrategy: .whenNotEqual())
    }

    public init(initialState: State, notifyStrategy: ObservableNotifyStrategy<State>) {
        self.state = initialState
        self.notifyStrategy = notifyStrategy
    }

    @discardableResult
    public func observe(using closure: @escaping (State) -> ()) -> ObservableToken {
        let id = observations.insert(closure)
        return ObservableToken { [weak self] in
            self?.observations.removeValue(forKey: id)
        }
    }

    internal func sink(_ state: State) {
        self.state = state
    }

    private func notifyTransition(_ oldState: State, to newState: State) {
        if notifyStrategy.shouldNotifyChange(from: oldState, to: newState) {
            observations.values.forEach { $0(newState) }
        }
    }
}

extension Dictionary where Key == UUID {
    fileprivate mutating func insert(_ value: Value) -> UUID {
        let id = UUID()
        self[id] = value
        return id
    }
}
