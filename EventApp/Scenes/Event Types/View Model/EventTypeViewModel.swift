//
//  EventTypeViewModel.swift
//  EventApp
//
//  Created by Ali Elsokary on 19/10/2021.
//  
//

import Foundation

class EventTypeViewModel {
	let id: String?
	let name: String?

	init(eventType: EventType) {
		self.id = eventType.id
		self.name = eventType.name
	}
}
