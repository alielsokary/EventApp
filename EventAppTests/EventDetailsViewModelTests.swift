//
//  EventDetailsViewModelTests.swift
//  EventAppTests
//
//  Created by Ali Elsokary on 20/10/2021.
//  
//

import XCTest
@testable import EventApp

class EventDetailsViewModelTests: XCTestCase {

	var sut: EventDetailsViewModel!
	var eventViewModel: EventViewModel!
	let event = Event(id: "1",
					  name: "abc",
					  cover: "https",
					  eventDescription: "abcd",
					  longitude: "11.12345",
					  latitude: "22.12345",
					  startDate: "Wednesday, September 7, 2016 3:29 PM",
					  endDate: "Saturday, December 3, 2016 8:50 AM")

	override func setUpWithError() throws {
		super.setUp()
		eventViewModel = EventViewModel(event: event)
		sut = EventDetailsViewModel(event: eventViewModel)
	}

	override func tearDownWithError() throws {
		super.tearDown()
		sut = nil
	}

	func test_id_returnsId() {
		XCTAssertEqual(sut.id.value, "1")
	}

	func test_name_returnsFullName() {
		XCTAssertEqual(sut.name.value, "abc")
	}

	func test_image_returnsEventCover() {
		XCTAssertEqual(sut.image.value, "https")
	}

	func test_eventDescription_returnsEventDescription() {
		XCTAssertEqual(sut.description.value, "abcd")
	}

	func test_eventLongitude_returnsEventLongitude() {
		XCTAssertEqual(sut.eventLongitude.value, 11.12345)
	}

	func test_eventLatitude_returnsEventLatitude() {
		XCTAssertEqual(sut.eventLatitude.value, 22.12345)
	}

	func test_eventStartDate_returnsEventStartDate() {
		XCTAssertEqual(sut.eventDate.value, "Wednesday, September 7, 2016 3:29 PM".formatedShortDate)
	}
}
