
open class MutableObservable<T>: Observable<T> {

    open override func sink(_ state: T) {
        super.sink(state)
    }
}
