//
//  EventViewModelTests.swift
//  EventAppTests
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import XCTest
@testable import EventApp

class EventViewModelTests: XCTestCase {

	let event = Event(id: "1",
					  name: "abc",
					  cover: "https",
					  eventDescription: "abcd",
					  longitude: "11.12345",
					  latitude: "22.12345",
					  startDate: "Wednesday, September 7, 2016 3:29 PM",
					  endDate: "Saturday, December 3, 2016 8:50 AM")

	var sut: EventViewModel!
	var storageServiceMock: RealmServiceMock!

    override func setUpWithError() throws {
		super.setUp()
		storageServiceMock = RealmServiceMock()
		sut = EventViewModel(event: event, storageService: storageServiceMock)
    }

    override func tearDownWithError() throws {
		super.tearDown()
        sut = nil
    }

	func test_id_returnsId() {
		XCTAssertEqual(sut.id, "1")
	}

	func test_name_returnsFullName() {
		XCTAssertEqual(sut.name, "abc")
	}

	func test_cover_returnsEventCover() {
		XCTAssertEqual(sut.cover, "https")
	}

	func test_eventDescription_returnsEventDescription() {
		XCTAssertEqual(sut.eventDescription, "abcd")
	}

	func test_eventLongitude_returnsEventLongitude() {
		XCTAssertEqual(sut.longitude, "11.12345")
	}

	func test_eventLatitude_returnsEventLatitude() {
		XCTAssertEqual(sut.latitude, "22.12345")
	}

	func test_eventStartDate_returnsEventStartDate() {
		XCTAssertEqual(sut.startDate, "Wednesday, September 7, 2016 3:29 PM".formatedShortDate)
	}

	func test_eventEndDate_returnsEventEndDate() {
		XCTAssertEqual(sut.endDate, "Saturday, December 3, 2016 8:50 AM")
	}

	func test_addEvent_to_favorites() {
		sut?.storageService.addToFavorite(event: sut!)
		XCTAssert(storageServiceMock.addToFavoriteCalled)
	}

	func test_fetchEvent_from_favorites() {
		_ = sut?.storageService.favoritedEvent(event: sut!)
		XCTAssert(storageServiceMock.fetchFavoriteObjectCalled)
	}

	func test_fetchedEvent_is_favoriteEvent() {
		sut?.storageService.addToFavorite(event: sut!)
		let fetchedEvent = sut?.storageService.favoritedEvent(event: sut!)
		let result = sut?.storageService.isFavorited(event: fetchedEvent!) == true
		XCTAssertTrue(result)
	}

	func test_removeEvent_from_favorites() {
		sut?.storageService.removeFromFavorite(event: sut!)
		XCTAssert(storageServiceMock.removeFromFavoriteCalled)
	}

	func test_availableEvent_after_save() {
		sut?.storageService.addToFavorite(event: sut!)
		let availableEvent = sut?.storageService.isFavorited(event: sut!)
		XCTAssertNotNil(availableEvent)
	}

}
