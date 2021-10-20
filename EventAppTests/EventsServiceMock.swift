//
//  EventsServiceMock.swift
//  EventAppTests
//
//  Created by Ali Elsokary on 20/10/2021.
//  
//

import Foundation
import RxSwift
@testable import EventApp

class EventsServiceMock: EventsService {

	var eventTypesReturnValue: Observable<EventTypes> = .empty()

	func getEventTypes() -> Observable<EventTypes> {
		return eventTypesReturnValue
	}

	var eventsReturnValue: Observable<Events> = .empty()
	var eventTypeArgument: String!
	var eventPageArgument: Int!

	func getEvents(type: String, page: Int) -> Observable<Events> {
		eventTypeArgument = type
		eventPageArgument = page
		return eventsReturnValue
	}
}
