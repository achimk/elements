import Foundation

open class Observable<Value> {
    private let notifyStrategy: ObservableNotifyStrategy<Value>
    private let observationContaner: ObservationContainer<Value>
    public private(set) var value: Value {
        didSet { notifyTransition(oldValue, to: value) }
    }

    public convenience init(
        _ initialValue: Value,
        observationContainer: ObservationContainer<Value> = .set())
    {
        self.init(
            initialValue: initialValue,
            notifyStrategy: .always(),
            observationContainer: observationContainer)
    }

    public convenience init(
        _ initialValue: Value,
        observationContainer: ObservationContainer<Value> = .set()) where Value: Equatable
    {
        self.init(
            initialValue: initialValue,
            notifyStrategy: .whenNotEqual(),
            observationContainer: observationContainer)
    }

    public init(initialValue: Value,
                notifyStrategy: ObservableNotifyStrategy<Value>,
                observationContainer: ObservationContainer<Value>)
    {
        self.value = initialValue
        self.notifyStrategy = notifyStrategy
        self.observationContaner = observationContainer
    }

    @discardableResult
    public func observe(using closure: @escaping (Value) -> ()) -> ObservableToken {
        observationContaner.insert(closure)
    }

    internal func accept(_ value: Value) {
        self.value = value
    }

    private func notifyTransition(_ oldValue: Value, to newValue: Value) {
        if notifyStrategy.shouldNotifyChange(from: oldValue, to: newValue) {
            observationContaner.forEach { (closure) in
                closure(newValue)
            }
        }
    }
}
