//
//  RealmServiceMock.swift
//  EventAppTests
//
//  Created by Ali Elsokary on 18/10/2021.
//  
//

import XCTest
import RealmSwift
@testable import EventApp

class RealmServiceMock: StorageService {

	var addToFavoriteCalled = false
	var fetchFavoriteObjectCalled = false
	var isFavoriteCalled = false
	var removeFromFavoriteCalled = false

	func addToFavorite(event viewModel: EventViewModel) {
		addToFavoriteCalled = true
	}

	func favoritedEvent(event viewModel: EventViewModel) -> EventViewModel {
		fetchFavoriteObjectCalled = true
		return EventViewModel()
	}

	func isFavorited(event viewModel: EventViewModel) -> Bool {
		isFavoriteCalled = true
		return true
	}

	func removeFromFavorite(event viewModel: EventViewModel) {
		removeFromFavoriteCalled = true
	}
}
