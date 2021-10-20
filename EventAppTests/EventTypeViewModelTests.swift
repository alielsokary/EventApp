//
//  EventTypeViewModelTests.swift
//  EventAppTests
//
//  Created by Ali Elsokary on 20/10/2021.
//  
//

import XCTest
@testable import EventApp

class EventTypeViewModelTests: XCTestCase {

	let eventType = EventType(id: "1",
							  name: "abc")
	var sut: EventTypeViewModel!

    override func setUpWithError() throws {
		super.setUp()
        sut = EventTypeViewModel(eventType: eventType)
    }

    override func tearDownWithError() throws {
		super.tearDown()
        sut = nil
    }

	func test_eventId_returnsEventId() {
		XCTAssertEqual(sut.id, "1")
	}

	func test_eventName_returnsEventName() {
		XCTAssertEqual(sut.name, "abc")
	}

}
