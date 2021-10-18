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

	var sut: EventViewModel?
	
    override func setUpWithError() throws {
		sut = EventViewModel()
		sut?.realmService = RealmServiceMock.sharedMock
    }

    override func tearDownWithError() throws {
        sut = nil
    }

	func test_addEvent_to_favorites() {
		sut?.addToFavorite(event: sut!)
		XCTAssert(RealmServiceMock.sharedMock.addToFavoriteCalled)
	}

	func test_fetchEvent_from_favorites() {
		_ = sut?.favoritedEvent(event: sut!)
		XCTAssert(RealmServiceMock.sharedMock.fetchFavoriteObjectCalled)
	}

	func test_removeEvent_from_favorites() {
		sut?.removeFromFavorite(event: sut!)
		XCTAssert(RealmServiceMock.sharedMock.removeFromFavoriteCalled)
	}
	
	func test_availableEvent_after_save() {
		sut?.addToFavorite(event: sut!)
		let availableEvent = sut?.isFavorited(event: sut!)
		XCTAssertNotNil(availableEvent)
	}

}
