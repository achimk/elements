import XCTest
import Elements

final class RignBufferTests: XCTestCase {
    
    func test_whenAppendOneElement_shouldContainOneElement() {
        var ring = RingBuffer<Int>(count: 3)
        ring.append(1)

        XCTAssertEqual(countElements(in: ring), 1)
        XCTAssertEqual(Array(ring.makeIterator()), [1])
    }
    
    func test_whenAppendAllAvailableSpace_shouldContainAllElements() {
        var ring = RingBuffer<Int>(count: 3)
        ring.append(1)
        ring.append(2)
        ring.append(3)

        XCTAssertEqual(countElements(in: ring), 3)
        XCTAssertEqual(Array(ring.makeIterator()), [1, 2, 3])
    }
    
    func test_whenAppendAndOverwriteElement_shouldNotContainFirstElement() {
        var ring = RingBuffer<Int>(count: 3)
        ring.append(1)
        ring.append(2)
        ring.append(3)
        ring.append(4)

        XCTAssertEqual(countElements(in: ring), 3)
        XCTAssertEqual(Array(ring.makeIterator()), [2, 3, 4])
    }
    
    func test_whenAppendToOneSizeRing_shouldOverrideElement() {
        var ring = RingBuffer<Int>(count: 1)
        ring.append(1)
        XCTAssertEqual(countElements(in: ring), 1)
        XCTAssertEqual(Array(ring.makeIterator()), [1])
        
        ring.append(2)
        XCTAssertEqual(countElements(in: ring), 1)
        XCTAssertEqual(Array(ring.makeIterator()), [2])
        
        ring.append(3)
        XCTAssertEqual(countElements(in: ring), 1)
        XCTAssertEqual(Array(ring.makeIterator()), [3])
    }
    
    func test_whenWriteAndRead_shouldIterateWithFixedSize() {
        var buffer = RingBuffer<Int>(count: 5)
        buffer.write(123)
        buffer.write(456)
        buffer.write(789)
        buffer.write(666)

        XCTAssertEqual(buffer.read(), 123)
        XCTAssertEqual(buffer.read(), 456)
        XCTAssertEqual(buffer.read(), 789)

        buffer.write(333)
        buffer.write(555)

        XCTAssertEqual(buffer.read(), 666)
        XCTAssertEqual(buffer.read(), 333)
        XCTAssertEqual(buffer.read(), 555)
        XCTAssertEqual(buffer.read(), nil)
    }
}

private func countElements<T>(in ring: RingBuffer<T>) -> Int {
    var counter = 0
    ring.forEach { (_) in
        counter += 1
    }
    return counter
}
