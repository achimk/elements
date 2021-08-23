import XCTest
import Elements

class ObservableBagTests: XCTestCase {

    func test_insertObservableTokens_shouldDisposeAllTokens() {
        var output: [Int] = []
        let bag = ObservableBag()
        bag.insert(ObservableToken { output.append(1) })
        bag.insert(ObservableToken { output.append(2) })
        bag.insert(ObservableToken { output.append(3) })

        bag.dispose()

        XCTAssertEqual(output, [1, 2, 3])
    }

    func test_insertObservableTokensByArray_shouldDisposeAllTokens() {
        var output: [Int] = []
        let bag = ObservableBag()
        bag.insert([
            ObservableToken { output.append(1) },
            ObservableToken { output.append(2) },
            ObservableToken { output.append(3) }
        ])

        bag.dispose()

        XCTAssertEqual(output, [1, 2, 3])
    }

    func test_insertObservableTokensByArrayLiteral_shouldDisposeAllTokens() {
        var output: [Int] = []
        let bag = ObservableBag()
        bag.insert(
            ObservableToken { output.append(1) },
            ObservableToken { output.append(2) },
            ObservableToken { output.append(3) }
        )

        bag.dispose()

        XCTAssertEqual(output, [1, 2, 3])
    }
}


