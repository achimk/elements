import XCTest
import Elements

final class NonEmptyTests: XCTestCase {
    
    func test_whenInitializeWithEmptyCollection_shouldReturnNil() {
        let empty: [Int] = []
        let result = NonEmpty(rawValue: empty)
        XCTAssertEqual(result.isPresent, false)
    }
    
    func test_whenInitializeWithNonEmptyCollection_shouldReturnNonEmpty() {
        let nonEmpty: [Int] = [1]
        let result = NonEmpty(rawValue: nonEmpty)
        XCTAssertEqual(result.isPresent, true)
    }
}
