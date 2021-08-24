
open class MutableObservable<Value>: Observable<Value> {

    open override func accept(_ state: Value) {
        super.accept(state)
    }
}
