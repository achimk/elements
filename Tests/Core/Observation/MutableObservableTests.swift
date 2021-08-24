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
        let observable = MutableObservable(1)

        var output: [Int] = []
        observable.observe { (value) in
            output.append(value)
        }

        observable.accept(2)
        observable.accept(2)
        observable.accept(2)
        observable.accept(3)
        observable.accept(3)
        observable.accept(3)

        XCTAssertEqual(output, [2, 3])
    }

    func test_notifyNonEquatableTypes_alwaysWhenChanged() {
        let observable = MutableObservable(NonEquatable(1))

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

        input.forEach { observable.accept($0) }

        XCTAssertEqual(output.map { $0.value }, input.map { $0.value })
    }

    func test_breakObservation_shouldNotNotifyChange() {
        let observable = MutableObservable(1)

        var output: [Int] = []
        let token = observable.observe { (value) in
            output.append(value)
        }

        observable.accept(2)
        observable.accept(3)
        observable.accept(4)
        token.cancel()
        observable.accept(5)
        observable.accept(6)
        observable.accept(7)

        XCTAssertEqual(output, [2, 3, 4])
    }
}
