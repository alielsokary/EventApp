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

	// MARK: - Inputs

	/// Call to reload Events.
	let reload: AnyObserver<Void>

	/// Call to update current Event Type. Causes reload of the Events.
	let setEventType: AnyObserver<String>

	let selectedEvent = PublishSubject<EventViewModel>()

	// MARK: - Outputs

	let title: Observable<String>

	var events: Observable<[EventViewModel]>

	let isLoading: Observable<Bool>

	let alertMessage: Observable<String>

	init(service: EventsService, currentEventType: String = "Music") {
		self.service = service

		let _title = BehaviorSubject<String>(value: "Events")
		self.title = _title.asObserver()

		let _events = BehaviorSubject<[EventViewModel]>(value: [])
		self.events = _events.asObservable()

		let _reload = PublishSubject<Void>()
		self.reload = _reload.asObserver()

		let _isLoading = BehaviorSubject<Bool>(value: false)
		self.isLoading = _isLoading.asObserver()

		let _currentEventType = BehaviorSubject<String>(value: currentEventType)
		self.setEventType = _currentEventType.asObserver()

		let _alertMessage = PublishSubject<String>()
		self.alertMessage = _alertMessage.asObservable()

		_isLoading.onNext(true)
		self.events = Observable.combineLatest(_reload, _currentEventType) { _, eventType in eventType }
			.flatMapLatest { eventType in
				service.getEvents(type: eventType, page: 1).catch { error in
					_isLoading.onNext(false)
					guard let error = error as? APIError else { return Observable.empty() }
					switch error {
					case .noInternet:
						_isLoading.onNext(false)
					default:
						_isLoading.onNext(false)
					}
					_alertMessage.onNext(error.localizedDescription)
					return Observable.empty()
				}
			}.map { events in
				_isLoading.onNext(false)
				return events.compactMap { EventViewModel(event: $0) }
			}
	}

}
