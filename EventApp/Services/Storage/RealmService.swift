//
//  RealmService.swift
//  EventApp
//
//  Created by Ali Elsokary on 17/10/2021.
//  
//

import Foundation
import RealmSwift

class RealmService {

	private init() {}
	static let shared = RealmService()

	var realm = try? Realm()

	func create<T: Object>(_ object: T) {
		do {
			try realm?.write {
				realm?.create(T.self, value: object, update: .modified)
			}
		} catch {
			print(error)
		}
	}

	func getObject<T: Object>(type: T.Type, key: String) -> T? {
		return realm?.object(ofType: T.self, forPrimaryKey: key)
	}

	func isAvailable<T: Object>(type: T.Type, key: String) -> Bool {
		let object = realm?.object(ofType: T.self, forPrimaryKey: key)
		return object != nil && object?.isInvalidated == false
	}

	func delete<T: Object>(_ object: T) {
		do {
			try realm?.write {
				realm?.delete(object)
			}
		} catch {
			print(error)
		}
	}
}
