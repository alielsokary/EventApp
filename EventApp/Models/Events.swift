//
//  Events.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import Foundation

typealias Events = [Event]

// MARK: - Event
struct Event: Codable {
	let id, name: String?
	let cover: String?
	let eventDescription: String?
	let longitude, latitude, startDate, endDate: String?

	enum CodingKeys: String, CodingKey {
		case longitude, latitude
		case endDate = "end_date"
		case startDate = "start_date"
		case eventDescription = "description"
		case cover, name, id
	}
}
