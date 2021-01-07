import XCTest
import Elements

final class ActivityStateTests: XCTestCase {
    
    typealias State = ActivityState<Int, String>
    
    struct TestError: Error, Equatable { }
    
    func testIsInitial() {
        let state = State.initial
        XCTAssertTrue(state.isInitial == true)
    }
    
    func testInvokedInitial() {
        var invoked = false
        let state = State.initial
        state.onInitial { invoked = true }
        XCTAssertTrue(invoked == true)
    }
    
    func testInitialValue() {
        let state = State.initial
        XCTAssertTrue(state.value == nil)
    }
    
    func testInitialError() {
        let state = State.initial
        XCTAssertTrue(state.error == nil)
    }
    
    func testIsLoading() {
        let state = State.loading
        XCTAssertTrue(state.isLoading == true)
    }
    
    func testInvokedLoading() {
        var invoked = false
        let state = State.loading
        state.onLoading { invoked = true }
        XCTAssertTrue(invoked == true)
    }
    
    func testLoadingValue() {
        let state = State.loading
        XCTAssertTrue(state.value == nil)
    }
    
    func testLoadingError() {
        let state = State.loading
        XCTAssertTrue(state.error == nil)
    }
    
    func testIsSuccess() {
        let state = State.success(1)
        XCTAssertTrue(state.isSuccess == true)
    }
    
    func testInvokedSuccess() {
        var invokedValue: Int?
        let state = State.success(1)
        state.onSuccess { invokedValue = $0 }
        XCTAssertTrue(invokedValue == 1)
    }
    
    func testSuccessValue() {
        let state = State.success(1)
        XCTAssertTrue(state.value == 1)
    }
    
    func testSuccessError() {
        let state = State.success(1)
        XCTAssertTrue(state.error == nil)
    }
    
    func testIsFailure() {
        let state = State.failure("test")
        XCTAssertTrue(state.isFailure == true)
    }
    
    func testInvokedFailure() {
        var invokedValue: String?
        let state = State.failure("test")
        state.onFailure { invokedValue = $0 }
        XCTAssertTrue(invokedValue == "test")
    }
    
    func testFailureValue() {
        let state = State.failure("test")
        XCTAssertTrue(state.value == nil)
    }
    
    func testFailureError() {
        let state = State.failure("test")
        XCTAssertTrue(state.error == "test")
    }
    
    func testEquatable() {
        let initial = State.initial
        let loading = State.loading
        let success = State.success(1)
        let failure = State.failure("test")
        
        XCTAssertTrue(initial == initial)
        XCTAssertTrue(loading == loading)
        XCTAssertTrue(success == success)
        XCTAssertTrue(failure == failure)
    }
    
    func testNotEquatable() {
        let initial = State.initial
        let loading = State.loading
        let success = State.success(1)
        let failure = State.failure("test")
        
        XCTAssertTrue(initial != loading)
        XCTAssertTrue(initial != success)
        XCTAssertTrue(initial != failure)
        XCTAssertTrue(loading != initial)
        XCTAssertTrue(loading != success)
        XCTAssertTrue(loading != failure)
        XCTAssertTrue(success != initial)
        XCTAssertTrue(success != loading)
        XCTAssertTrue(success != failure)
        XCTAssertTrue(failure != initial)
        XCTAssertTrue(failure != loading)
        XCTAssertTrue(failure != success)
    }
    
    func testResultConversion() {
     
        let initial = ActivityState<Int, TestError>.initial
        let loading = ActivityState<Int, TestError>.loading
        let success = ActivityState<Int, TestError>.success(1)
        let failure = ActivityState<Int, TestError>.failure(TestError())
        
        XCTAssertTrue(initial.result == nil)
        XCTAssertTrue(loading.result == nil)
        XCTAssertTrue(success.result != nil)
        XCTAssertTrue(failure.result != nil)
        
        success.result.ifPresent { (result) in
            XCTAssertTrue(result.value == 1)
        }
        
        failure.result.ifPresent { (result) in
            XCTAssertTrue(result.error == TestError())
        }
    }
}


extension ActivityStateTests {
    
    func testRaw() {
        
        let items: [ActivityStateRaw] = [
            .success,
            .success ,
            .failure,
            .success,
            .success
        ]
        
        let reduced = items.reduce(ActivityStateRaw.initial, reduce(_:_:))
        
        print(reduced)
    }
}

extension ActivityState where Success == Void {
    public static var success: ActivityState { return ActivityState.success(()) }
}

extension ActivityState where Failure == Void {
    public static var failure: ActivityState { return ActivityState.failure(()) }
}

public typealias ActivityStateRaw = ActivityState<Void, Void>

public func reduce(_ lhs: ActivityStateRaw, _ rhs: ActivityStateRaw) -> ActivityStateRaw {
    
    switch (lhs, rhs) {
    
    case (.initial, .loading): return .loading
    case (.loading, .initial): return .loading
        
    case (.initial, _): return .initial
    case (_, .initial): return .initial

    case (.loading, _): return .loading
    case (_, .loading): return .loading
    
    case (.failure, _): return .failure
    case (_, .failure): return .failure
    
    case (.success, .success): return .success
    }
}
