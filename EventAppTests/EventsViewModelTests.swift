//
//  EventsViewModelTests.swift
//  EventAppTests
//
//  Created by Ali Elsokary on 20/10/2021.
//  
//

import XCTest
import RxSwift
import RxTest
@testable import EventApp

class EventsViewModelTests: XCTestCase {

	let testEvent = Event(id: "1",
					  name: "abc",
					  cover: "https",
					  eventDescription: "abcd",
					  longitude: "11.12345",
					  latitude: "22.12345",
					  startDate: "Wednesday, September 7, 2016 3:29 PM",
					  endDate: "Saturday, December 3, 2016 8:50 AM")

	var testScheduler: TestScheduler!
	var disposeBag: DisposeBag!
	var service: EventsServiceMock!
	var viewModel: EventsViewModel!

    override func setUpWithError() throws {
		super.setUp()
		testScheduler = TestScheduler(initialClock: 0)
		disposeBag = DisposeBag()
		service = EventsServiceMock()
		viewModel = EventsViewModel(service: service)
    }

    override func tearDownWithError() throws {
		super.tearDown()
		disposeBag = nil
		viewModel = nil
		testScheduler = nil
    }

	func test_viewModel_EmitsValidTitle() {
		let result = testScheduler.start { self.viewModel.title }
		XCTAssertEqual(result.events, [.next(200, "Events")])
	}

	func test_eventTypes_ReturnsValidRequest() {
		let eventType = EventType(id: "1", name: "Music")
		service.eventTypesReturnValue = .just([eventType])

		viewModel.eventTypes
			.subscribe()
			.disposed(by: disposeBag)

		let result = testScheduler.start { self.viewModel.eventTypes.map({ _ in true }) }
		XCTAssertEqual(result.events, [.next(200, true)])
	}

	func test_reload_beforeTypeSelection_emitsAlertMessage() {
		let message = "Please select event type first."

		testScheduler.createHotObservable([.next(300, ())])
			.bind(to: viewModel.reload)
			.disposed(by: disposeBag)

		viewModel.events
			.subscribe()
			.disposed(by: disposeBag)

		let result = testScheduler.start { self.viewModel.alertMessage }
		XCTAssertEqual(result.events, [.next(300, message)])
	}

	func test_selectedEventType_emitsEventType() {
		let eventType = EventType(id: "1", name: "Music")
		let eventTypeViewModel = EventTypeViewModel(eventType: eventType)
		testScheduler.createHotObservable([.next(400, eventTypeViewModel)])
			.bind(to: viewModel.selectedEventType)
			.disposed(by: disposeBag)

		viewModel.eventTypes
			.subscribe()
			.disposed(by: disposeBag)

		let result = testScheduler.start { self.viewModel.eventTypes }
		XCTAssertEqual(result.events.count, 1)
	}

	func test_loadMore_requestsPaginatedData() {
		testScheduler.createHotObservable([.next(300, ())])
			.bind(to: viewModel.fetchPaginatedData)
			.disposed(by: disposeBag)

		let result = testScheduler.start { self.viewModel.events }
		XCTAssertEqual(result.events.count, 1)
	}

}
