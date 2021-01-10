import XCTest
import Elements

final class ChangeTests: XCTestCase {
    
    func testInitializeWithValue() {
        let change = Change(1)
        
        XCTAssertTrue(change.isModified == false)
        XCTAssertTrue(change.original == 1)
        XCTAssertTrue(change.value == 1)
    }
    
    func testInitializeWithEqualValues() {
        let change = Change(original: 1, value: 1)
        XCTAssertTrue(change.isModified == false)
        XCTAssertTrue(change.original == 1)
        XCTAssertTrue(change.value == 1)
    }
    
    func testInitializeWithNonEqualValues() {
        let change = Change(original: 1, value: 2)
        XCTAssertTrue(change.isModified == true)
        XCTAssertTrue(change.original == 1)
        XCTAssertTrue(change.value == 2)
    }
    
    func testUpdateWithEqualValue() {
        let change = Change(original: 1, value: 2).updated(1)
        XCTAssertTrue(change.isModified == false)
        XCTAssertTrue(change.original == 1)
        XCTAssertTrue(change.value == 1)
    }
    
    func testUpdateWithNonEqualValue() {
        let change = Change(original: 1, value: 1).updated(2)
        XCTAssertTrue(change.isModified == true)
        XCTAssertTrue(change.original == 1)
        XCTAssertTrue(change.value == 2)
    }
}
