import XCTest
import Elements

class ObservableTokenTests: XCTestCase {

    func test_cancelToken_shouldInvokeCancelClosure() {
        var isInvoked = false
        let token = ObservableToken { isInvoked = true }

        token.cancel()

        XCTAssertTrue(isInvoked)
    }

    func test_insertToBag_shouldCancelThroughBag() {
        var isInvoked = false
        let token = ObservableToken { isInvoked = true }
        let bag = ObservableBag()

        token.insert(into: bag)

        bag.dispose()

        XCTAssertTrue(isInvoked)
    }
}
