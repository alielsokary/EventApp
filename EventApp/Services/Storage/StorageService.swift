//
//  StorageService.swift
//  EventApp
//
//  Created by Ali Elsokary on 18/10/2021.
//  
//

import Foundation

protocol StorageService {
	func addToFavorite(event viewModel: EventViewModel)
	func favoritedEvent(event viewModel: EventViewModel) -> EventViewModel
	func isFavorited(event viewModel: EventViewModel) -> Bool
	func removeFromFavorite(event viewModel: EventViewModel)
}

class StorageServiceImpl: StorageManager, StorageService {
	func addToFavorite(event viewModel: EventViewModel) {
		create(viewModel)
	}

	func removeFromFavorite(event viewModel: EventViewModel) {
		delete(viewModel)
	}

	func isFavorited(event viewModel: EventViewModel) -> Bool {
		return isAvailable(type: EventViewModel.self, key: viewModel.id ?? "")
	}

	func favoritedEvent(event viewModel: EventViewModel) -> EventViewModel {
		let favoritedEvent = getObject(type: EventViewModel.self, key: viewModel.id ?? "")!
		return favoritedEvent
	}
}
