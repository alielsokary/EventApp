//
//  SplashCoordinator.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import RxSwift

class SplashCoordinator: BaseCoordinator<Void> {

	private let rootViewController: UIViewController

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	override func start() -> Observable<Void> {

		return Observable.empty()
	}
}
