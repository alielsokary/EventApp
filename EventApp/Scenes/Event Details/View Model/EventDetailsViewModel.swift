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

	private let event: EventViewModel

	let id = BehaviorRelay<String>(value: "")
	let name = BehaviorRelay<String>(value: "")

	init(event: EventViewModel) {
		self.event = event
		id.accept(event.id ?? "")
		name.accept(event.name ?? "")
	}
}
