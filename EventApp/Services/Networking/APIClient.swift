//
//  APIClient.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import Alamofire
import RxSwift

class APIClient {

	func request<T: Codable> (_ route: URLRequestBuilder) -> Observable<T> {
		return Observable<T>.create { observer in
			let request = AF.request(route).responseDecodable { (response: AFDataResponse<T>) in

				switch response.result {
				case .success(let value):
					observer.onNext(value)
					observer.onCompleted()

				case .failure(let error):
					switch response.response?.statusCode {
					case 403:
						observer.onError(APIError.eventtusForbidden)
					case 404:
						observer.onError(APIError.eventtusNotFound)
					case 500:
						observer.onError(APIError.eventtusInternalServerError)
					default:
						guard NetworkReachabilityManager()?.isReachable ?? false else {
							observer.onError(APIError.noInternet)
							return
						}
						observer.onError(error)
					}
				}
			}

			return Disposables.create {
				request.cancel()
			}
		}
	}

}
