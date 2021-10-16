//
//  EventViewModel.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import Foundation
import RxSwift

struct EventViewModel {
	let name, id: String?
	let cover: String?
	let eventDescription: String?
	let longitude, latitude: String?
	let endDate, startDate: String?

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

	var isFavorited: Observable<Bool> {
		return Observable.just(false)
	}

}
