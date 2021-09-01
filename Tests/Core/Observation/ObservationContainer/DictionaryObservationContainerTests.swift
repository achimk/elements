import XCTest
import Elements

class DictionaryObservationContainerTests: XCTestCase {

    func test_notifyValue_shouldCallAllInAnyOrder() {
        var notifiedList: [String] = []
        let consumerA: (Int) -> () = { _ in notifiedList.append("a") }
        let consumerB: (Int) -> () = { _ in notifiedList.append("b") }
        let consumerC: (Int) -> () = { _ in notifiedList.append("c") }
        let container = DictionaryObservationContainer<Int>()

        container.insert(consumerA)
        container.insert(consumerB)
        container.insert(consumerC)

        container.makeIterator().forEach {
            $0(1)
        }

        XCTAssertEqual(["a", "b", "c"], notifiedList.sorted())
    }
}
