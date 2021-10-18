//
//  EventViewModel.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import Foundation
import RxSwift
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

	let isAddedToFavorite = PublishSubject<Bool>()

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
	}

	func updateFavoriteStatus(event viewModel: EventViewModel) {
			if isFavorited(event: viewModel) {
				let favoritedEvent = favoritedEvent(event: viewModel)
				removeFromFavorite(event: favoritedEvent)
			} else {
				addToFavorite(event: viewModel)
			}
		isAddedToFavorite.onNext(isFavorited(event: viewModel))
	}

	private func addToFavorite(event viewModel: EventViewModel) {
		RealmService.shared.create(viewModel)
	}

	private func removeFromFavorite(event viewModel: EventViewModel) {
		RealmService.shared.delete(viewModel)
	}

	private func isFavorited(event viewModel: EventViewModel) -> Bool {
		return RealmService.shared.isAvailable(type: EventViewModel.self, key: viewModel.id ?? "")
	}

	private func favoritedEvent(event viewModel: EventViewModel) -> EventViewModel {
		let favoritedEvent = RealmService.shared.getObject(type: EventViewModel.self, key: viewModel.id ?? "")!
		return favoritedEvent
	}

	var isFavorited: Observable<Bool> {
		return Observable.just(isFavorited(event: self))
	}

}
