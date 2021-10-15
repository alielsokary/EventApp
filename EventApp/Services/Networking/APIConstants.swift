//
//  APIConstants.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import Foundation

struct APIConstants {

	static let eventtusURL = "https://private-7466b-eventtuschanllengeapis.apiary-mock.com"

	enum ParameterKey: String {
		case eventType = "event_type"
		case page
	}

	enum HTTPHeaderKeyField: String {
		case contentType = "Content-Type"
		case acceptType = "Accept"
	}

	enum HTTPHeaderValueField: String {
		case applicationJson = "application/json"
	}

}
