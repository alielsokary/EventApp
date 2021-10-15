//
//  URLRequestBuilder.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {

	var mainURL: URL { get }

	var requestURL: URL { get }

	var path: ServerPaths { get }

	var headers: HTTPHeaders { get }

	var parameters: Parameters? { get }

	var method: HTTPMethod { get }

	var encoding: ParameterEncoding { get }

	var urlRequest: URLRequest { get }
}

extension URLRequestBuilder {

	var mainURL: URL {
		#if DEBUG
			return URL(string: "\(APIConstants.eventtusURL)")!
		#else
			return URL(string: "\(APIConstants.eventtusURL)")!
		#endif
	}

	var requestURL: URL {
		return mainURL.appendingPathComponent(path.rawValue)
	}

	var headers: HTTPHeaders {
		var headers = HTTPHeaders()
		headers[APIConstants.HTTPHeaderKeyField.contentType.rawValue] = APIConstants.HTTPHeaderValueField.applicationJson.rawValue
		headers[APIConstants.HTTPHeaderKeyField.acceptType.rawValue] = APIConstants.HTTPHeaderValueField.applicationJson.rawValue
		return headers
	}

	var defaultParams: Parameters {
		let params = Parameters()
		return params
	}

	var encoding: ParameterEncoding {
		switch method {
		case .get:
			return URLEncoding.default

		default:
			return JSONEncoding.default
		}
	}

	var urlRequest: URLRequest {
		var request = URLRequest(url: requestURL)
		request.httpMethod = method.rawValue
		headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.name)}
		return request
	}

	func asURLRequest() throws -> URLRequest {
		return try encoding.encode(urlRequest, with: parameters)
	}
}
