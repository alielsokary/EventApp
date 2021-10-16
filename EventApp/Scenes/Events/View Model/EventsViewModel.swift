//
//  EventsViewModel.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import Foundation
import RxSwift
import RxCocoa

class EventsViewModel {

	private let service: EventsService!
	private let disposeBag = DisposeBag()

	let title = BehaviorRelay<String>(value: "Events")

	let isLoading = BehaviorSubject<Bool>(value: false)
	let noInternet = BehaviorSubject<Bool>(value: false)
	private let _alertMessage = PublishSubject<String>()

	let events = BehaviorSubject<[EventViewModel]>(value: [])
	let selectedEvent = PublishSubject<EventViewModel>()

	let alertMessage: Observable<String>

	init(service: EventsService) {
		self.service = service
		self.alertMessage = _alertMessage.asObservable()
	}

	func start() {
		self.isLoading.onNext(true)
		self.noInternet.onNext(false)
		service.getEvents(type: "Music", page: 1)
			.subscribe(onNext: { [weak self] events in
			guard let self = self else { return }
			self.isLoading.onNext(false)
				let eventList = events.compactMap { EventViewModel(event: $0) }
				self.events.onNext(eventList)
		}, onError: { [weak self] error in
			self?.isLoading.onNext(false)
			guard let error = error as? APIError else { return }
			switch error {
			case .noInternet:
				self?.noInternet.onNext(true)
			default:
				self?._alertMessage.onNext(error.localizedDescription)
			}
		}).disposed(by: disposeBag)

	}

}
