//
//  EventTypes.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import Foundation

typealias EventTypes = [EventType]

// MARK: - EventType
struct EventType: Codable {
	let name, id: String?
}
