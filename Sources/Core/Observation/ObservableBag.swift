
public final class ObservableBag {
    private var tokens: [ObservableToken] = []

    public init() { }

    deinit {
        dispose()
    }

    public func insert(_ token: ObservableToken) {
        tokens.append(token)
    }

    public func insert(_ tokens: ObservableToken...) {
        self.tokens.append(contentsOf: tokens)
    }

    public func insert(_ tokens: [ObservableToken]) {
        self.tokens.append(contentsOf: tokens)
    }

    public func dispose() {
        tokens.forEach { $0.cancel() }
        tokens.removeAll()
    }
}
