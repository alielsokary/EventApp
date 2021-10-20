//
//  EventsService.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import RxSwift

protocol EventsService {
	func getEventTypes() -> Observable<EventTypes>
	func getEvents(type: String, page: Int) -> Observable<Events>
}

class EventsServiceImpl: APIClient, EventsService {
	func getEventTypes() -> Observable<EventTypes> {
		request(EventtusRouter.geEventTypes)
	}

	func getEvents(type: String, page: Int) -> Observable<Events> {
		request(EventtusRouter.getEvents(type: type, page: page))
	}
}
