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

	var storageService: StorageService!

	convenience init(event: Event, storageService: StorageService = StorageServiceImpl()) {
		self.init()
		self.storageService = storageService
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
		if storageService.isFavorited(event: viewModel) {
			let favoritedEvent = storageService.favoritedEvent(event: viewModel)
			storageService.removeFromFavorite(event: favoritedEvent)
			} else {
				storageService.addToFavorite(event: viewModel)
			}
		_isFavorited.accept(storageService.isFavorited(event: viewModel))
	}

	var isFavorited: Observable<Bool> {
		_isFavorited.asObservable().map { _ in self.storageService.isFavorited(event: self) }
	}

}
