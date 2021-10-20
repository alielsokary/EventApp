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

	/// Event type property to be passed as a parameter in getEvents request.
	private let eventType = BehaviorRelay<String>(value: "")

	/// Call to update current selected event type. Causes reload of the events.
	let selectedEventType = PublishSubject<EventTypeViewModel>()

	/// Call to fetch paginated events.
	let fetchPaginatedData = PublishSubject<Void>()

	/// Selected event to be passed in coordinator to navigate to event details
	let selectedEvent = PublishSubject<EventViewModel>()

	/// Alert in case pull to refresh action was made before an event type was selected.
	/// I choose this solution rather than assigning a default parameter of 'Sports' (the first event type)
	private let emptyCategoryAlert = "Please select event type first."

	private let _title = BehaviorSubject<String>(value: "Events")
	private let _events = BehaviorRelay<[EventViewModel]>(value: [])
	private let _eventTypes = BehaviorSubject<[EventTypeViewModel]>(value: [])

	private let _reload = PublishSubject<Void>()
	private let _isLoading = BehaviorSubject<Bool>(value: false)
	private let _alertMessage = PublishSubject<String>()

	private var page = 1
	private var maxPage = 3
	private var isRefreshRequstActive = false
	private var isPaginationRequestActive = false

	// MARK: - Outputs

	/// Emits a  title for navigation item title.
	let title: Observable<String>

	/// Emits an array of fetched event types.
	let evetTypes: Observable<[EventTypeViewModel]>

	/// Emits an array of fetched events.
	let events: Observable<[EventViewModel]>

	/// Emits a boolean to decide when to show/hide activity indicator.
	let isLoading: Observable<Bool>

	/// Emits message or an error messages to be shown.
	let alertMessage: Observable<String>

	init(service: EventsService) {
		self.service = service

		self.title = _title.asObserver()

		self.evetTypes = _eventTypes.asObservable()
		self.events = _events.asObservable()

		self.reload = _reload.asObserver()
		self.isLoading = _isLoading.asObserver()
		self.alertMessage = _alertMessage.asObservable()

		getEventTypes()

		selectedEventType.subscribe { [weak self] eventType in
			guard let self = self else { return }
			guard let eventType = eventType.element?.name else { return }
			self.eventType.accept(eventType)
			self.getEvents(isRefreshControl: true)
		}.disposed(by: disposeBag)

		_reload.subscribe { [weak self] _ in
			guard let self = self else { return }
			guard !self.emptyEventType() else { return }
			self.isPaginationRequestActive = false
			self.page = 1
			self._events.accept([])
			self.getEvents(page: self.page, isRefreshControl: true)
		}.disposed(by: disposeBag)

		fetchPaginatedData.subscribe { [weak self] _ in
			guard let self = self else { return }
			self.getEvents(page: self.page, isRefreshControl: false)
		}.disposed(by: disposeBag)

	}

}

// MARK: - Vaildations

private extension EventsViewModel {

/// Validate if `event type` was selected or not.
	func emptyEventType() -> Bool {
		let emptyEventType = self.eventType.value.isEmpty
		if emptyEventType {
			self._alertMessage.onNext(self.emptyCategoryAlert)
			self._events.accept([])
			return true
		}
		return false
	}
}

// MARK: - Service Calls

private extension EventsViewModel {

	func getEventTypes() {
		_isLoading.onNext(true)
		service.getEventTypes()
			.subscribe { [weak self] eventTypes in
				guard let self = self else { return }
				self._isLoading.onNext(false)
				let eventTypeList = eventTypes.compactMap { EventTypeViewModel(eventType: $0)}
				self._eventTypes.onNext(eventTypeList)
		} onError: { error in
			guard let error = error as? APIError else { return }
			switch error {
			case .noInternet:
				self._isLoading.onNext(false)
				self._eventTypes.onNext([])
			default:
				self._isLoading.onNext(false)
			}
			self._alertMessage.onNext(error.localizedDescription)
		}.disposed(by: disposeBag)
	}

	func getEvents(page: Int = 1, isRefreshControl: Bool) {
		if isPaginationRequestActive || isRefreshRequstActive { return }
		self.isRefreshRequstActive = isRefreshControl

		if self.page > maxPage {
			isPaginationRequestActive = false
			return
		}

		isPaginationRequestActive = true

		_isLoading.onNext(true)
		service.getEvents(type: self.eventType.value, page: self.page)
			.subscribe { [weak self] eventTypes in
				guard let self = self else { return }
				self._isLoading.onNext(false)
				self.isPaginationRequestActive = false
				self.isRefreshRequstActive = false
				let eventList = eventTypes.compactMap { EventViewModel(event: $0)}
				if self.page == 1 {
					self._events.accept(eventList)
				} else {
					let previousData = self._events.value
					self._events.accept(previousData + eventList)
				}
				self.page += 1

		} onError: { error in
			guard let error = error as? APIError else { return }
			switch error {
			case .noInternet:
				self._isLoading.onNext(false)
				self._events.accept([])
			default:
				self._isLoading.onNext(false)
			}
			self._alertMessage.onNext(error.localizedDescription)
		}.disposed(by: disposeBag)
	}
}
