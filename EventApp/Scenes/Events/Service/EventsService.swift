//
//  EventsService.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import RxSwift

protocol EventsService {
	func getEvents(type: String, page: Int) -> Observable<Events>
}

class EventsServiceImpl: APIClient, EventsService {
	func getEvents(type: String, page: Int) -> Observable<Events> {
		return request(EventtusRouter.getEvents(type: type, page: page))
	}
}
