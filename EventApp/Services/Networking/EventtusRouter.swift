//
//  EventtusRouter.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import Alamofire

enum EventtusRouter: URLRequestBuilder {

	case geEventTypes
	case getEvents(type: String, page: Int)

	// MARK: - Path
	var path: ServerPaths {
		switch self {
		case .geEventTypes:
			return .eventTypes

		case .getEvents:
			return .events
		}
	}

	// MARK: - Parameters
	var parameters: Parameters? {
		var params = defaultParams
		switch self {
		case .getEvents(let type, let page):
			params[APIConstants.ParameterKey.eventType.rawValue] = type
			params[APIConstants.ParameterKey.page.rawValue] = page
			return params
		default:
			return params
		}
	}

	// MARK: - Methods
	var method: HTTPMethod {
		return .get
	}
}
