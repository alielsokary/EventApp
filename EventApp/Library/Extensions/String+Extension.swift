//
//  String+Extension.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import Foundation

extension String {

	var formatedShortDate: String {
		var dateString = self
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE, MMMM d, yyyy HH:mm a"

		if let date = formatter.date(from: dateString) {
			formatter.dateFormat = "d MMMM, yyyy"
			let outputDate = formatter.string(from: date)
			dateString = outputDate
		}
		return dateString
	}
}
