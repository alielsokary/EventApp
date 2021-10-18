//
//  EventViewModel.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class EventViewModel: Object {
	@Persisted(primaryKey: true) var id: String?
	@Persisted var name: String?
	@Persisted var cover: String?
	@Persisted var eventDescription: String?
	@Persisted var latitude: String?
	@Persisted var longitude: String?
	@Persisted var startDate: String?
	@Persisted var endDate: String?

	private let _isFavorited = BehaviorRelay<Bool>(value: false)

	var realmService: RealmService!

	convenience init(event: Event) {
		self.init()
		self.id = event.id
		self.name = event.name
		self.cover = event.cover
		self.eventDescription = event.eventDescription
		self.startDate = event.startDate?.formatedShortDate
		self.endDate = event.endDate
		self.latitude = event.latitude
		self.longitude = event.longitude
		self.realmService = RealmService.shared
	}

	func updateFavoriteStatus(event viewModel: EventViewModel) {
			if isFavorited(event: viewModel) {
				let favoritedEvent = favoritedEvent(event: viewModel)
				removeFromFavorite(event: favoritedEvent)
			} else {
				addToFavorite(event: viewModel)
			}
		_isFavorited.accept(isFavorited(event: viewModel))
	}

	var isFavorited: Observable<Bool> {
		_isFavorited.asObservable().map { _ in self.isFavorited(event: self) }
	}

}

extension EventViewModel: StorageSession {
	func addToFavorite(event viewModel: EventViewModel) {
		realmService.create(viewModel)
	}

	func removeFromFavorite(event viewModel: EventViewModel) {
		realmService.delete(viewModel)
	}

	func isFavorited(event viewModel: EventViewModel) -> Bool {
		return realmService.isAvailable(type: EventViewModel.self, key: viewModel.id ?? "")
	}

	func favoritedEvent(event viewModel: EventViewModel) -> EventViewModel {
		let favoritedEvent = realmService.getObject(type: EventViewModel.self, key: viewModel.id ?? "")!
		return favoritedEvent
	}
}
