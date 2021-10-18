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

class RealmServiceMock: RealmService {

	static let sharedMock = RealmServiceMock()

	var addToFavoriteCalled = false
	var fetchFavoriteObjectCalled = false
	var removeFromFavoriteCalled = false

	override func create<T>(_ object: T) where T: Object {
		addToFavoriteCalled = true
	}

	override func getObject<T>(type: T.Type, key: String) -> T? where T: Object {
		fetchFavoriteObjectCalled = true
		return T.init()
	}

	override func delete<T>(_ object: T) where T: Object {
		removeFromFavoriteCalled = true
	}

}
