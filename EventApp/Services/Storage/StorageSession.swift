//
//  StorageSession.swift
//  EventApp
//
//  Created by Ali Elsokary on 18/10/2021.
//  
//

import Foundation

protocol StorageSession {
	func addToFavorite(event viewModel: EventViewModel)
	func favoritedEvent(event viewModel: EventViewModel) -> EventViewModel
	func isFavorited(event viewModel: EventViewModel) -> Bool
	func removeFromFavorite(event viewModel: EventViewModel)
}
