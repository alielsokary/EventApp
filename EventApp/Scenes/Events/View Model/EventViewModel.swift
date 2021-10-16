//
//  EventViewModel.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import Foundation

struct EventViewModel {
	let longitude, latitude, endDate, startDate: String?
	let eventDescription: String?
	let cover: String?
	let name, id: String?

	init(event: Event) {
		self.id = event.id
		self.name = event.name
		self.cover = event.cover
		self.eventDescription = event.eventDescription
		self.startDate = event.startDate
		self.endDate = event.endDate
		self.latitude = event.latitude
		self.longitude = event.longitude
	}
}
