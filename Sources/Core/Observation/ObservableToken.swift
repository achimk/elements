
public struct ObservableToken {
    private let onDidCancel: () -> ()

    public init(_ onDidCancel: @escaping () -> ()) {
        self.onDidCancel = onDidCancel
    }

    public func cancel() {
        onDidCancel()
    }

    public func insert(into bag: ObservableBag) {
        bag.insert(self)
    }
}
