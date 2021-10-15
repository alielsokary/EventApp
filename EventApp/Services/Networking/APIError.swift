//
//  APIError.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import Foundation

enum APIError: Int, Error {
	case noInternet
	case eventtusUnauthorized = 401
	case eventtusForbidden = 403
	case eventtusNotFound = 404
	case eventtusInternalServerError = 500
	case unknown
}

extension APIError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .noInternet:
			return "No Internet Connection. Please check your connection and try again"
		default:
			return "Unknown error occured"
		}
	}
}
