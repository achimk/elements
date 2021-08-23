import XCTest
import Elements

class MutableObservableTests: XCTestCase {

    struct NonEquatable {
        var value: Int
        init(_ value: Int) {
            self.value = value
        }
    }

    func test_notifyEquatableTypes_onlyWhenNotEqual() {
        let observable = MutableObservable(initialState: 1)

        var output: [Int] = []
        observable.observe { (value) in
            output.append(value)
        }

        observable.sink(2)
        observable.sink(2)
        observable.sink(2)
        observable.sink(3)
        observable.sink(3)
        observable.sink(3)

        XCTAssertEqual(output, [2, 3])
    }

    func test_notifyNonEquatableTypes_alwaysWhenChanged() {
        let observable = MutableObservable(initialState: NonEquatable(1))

        var output: [NonEquatable] = []
        observable.observe { (value) in
            output.append(value)
        }

        let input = [
            NonEquatable(2),
            NonEquatable(2),
            NonEquatable(2),
            NonEquatable(3),
            NonEquatable(3),
            NonEquatable(3)
        ]

        input.forEach { observable.sink($0) }

        XCTAssertEqual(output.map { $0.value }, input.map { $0.value })
    }

    func test_breakObservation_shouldNotNotifyChange() {
        let observable = MutableObservable(initialState: 1)

        var output: [Int] = []
        let token = observable.observe { (value) in
            output.append(value)
        }

        observable.sink(2)
        observable.sink(3)
        observable.sink(4)
        token.cancel()
        observable.sink(5)
        observable.sink(6)
        observable.sink(7)

        XCTAssertEqual(output, [2, 3, 4])
    }
}
