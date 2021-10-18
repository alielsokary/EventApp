//
//  EventDetailsViewModel.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import Foundation
import RxSwift
import RxCocoa

class EventDetailsViewModel {

	let event: EventViewModel
	private let disposeBag = DisposeBag()

	let id = BehaviorRelay<String>(value: "")
	let name = BehaviorRelay<String>(value: "")
	let image = BehaviorRelay<String>(value: "")
	let description = BehaviorRelay<String>(value: "")
	let eventDate = BehaviorRelay<String>(value: "")
	let eventLatitude = BehaviorRelay<Double>(value: 0.0)
	let eventLongitude = BehaviorRelay<Double>(value: 0.0)
	let isFavorited = BehaviorRelay<Bool>(value: false)

	init(event: EventViewModel) {
		self.event = event
		id.accept(event.id ?? "")
		name.accept(event.name ?? "")
		image.accept(event.cover ?? "")
		description.accept(event.eventDescription ?? "")
		eventDate.accept(event.startDate?.formatedShortDate ?? "")
		eventLatitude.accept(Double(event.latitude ?? "") ?? 0.0)
		eventLongitude.accept(Double(event.longitude ?? "") ?? 0.0)
		event.isFavorited
			.bind(to: isFavorited)
			.disposed(by: disposeBag)
	}
}
