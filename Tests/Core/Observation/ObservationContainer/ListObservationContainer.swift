import XCTest
import Elements

class ListObservationContainerTests: XCTestCase {

    func test_notifyValue_shouldCallAllInCorrectOrder() {
        var notifiedList: [String] = []
        let consumerA: (Int) -> () = { _ in notifiedList.append("a") }
        let consumerB: (Int) -> () = { _ in notifiedList.append("b") }
        let consumerC: (Int) -> () = { _ in notifiedList.append("c") }
        let container = ListObservationContainer<Int>()

        container.insert(consumerA)
        container.insert(consumerB)
        container.insert(consumerC)

        container.makeIterator().forEach {
            $0(1)
        }

        XCTAssertEqual(["a", "b", "c"], notifiedList)
    }
}
