import Foundation

open class Observable<Value> {
    private var observations: [UUID: (Value) -> ()] = [:]
    private let notifyStrategy: ObservableNotifyStrategy<Value>
    public private(set) var value: Value {
        didSet { notifyTransition(oldValue, to: value) }
    }

    public convenience init(_ initialValue: Value) {
        self.init(initialValue: initialValue, notifyStrategy: .always())
    }

    public convenience init(_ initialValue: Value) where Value: Equatable {
        self.init(initialValue: initialValue, notifyStrategy: .whenNotEqual())
    }

    public init(initialValue: Value, notifyStrategy: ObservableNotifyStrategy<Value>) {
        self.value = initialValue
        self.notifyStrategy = notifyStrategy
    }

    @discardableResult
    public func observe(using closure: @escaping (Value) -> ()) -> ObservableToken {
        let id = observations.insert(closure)
        return ObservableToken { [weak self] in
            self?.observations.removeValue(forKey: id)
        }
    }

    internal func accept(_ value: Value) {
        self.value = value
    }

    private func notifyTransition(_ oldValue: Value, to newValue: Value) {
        if notifyStrategy.shouldNotifyChange(from: oldValue, to: newValue) {
            observations.values.forEach { $0(newValue) }
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
