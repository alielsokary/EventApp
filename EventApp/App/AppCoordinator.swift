//
//  AppCoordinator.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

	private let window: UIWindow

	init(window: UIWindow) {
		self.window = window
	}

	override func start() -> Observable<Void> {
		guard let viewController = Storyboard.main.splashViewController() else { return Observable.empty() }
		let navigationController = UINavigationController(rootViewController: viewController)
		let splashCoordinator = SplashCoordinator(rootViewController: navigationController.viewControllers[0])

		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		return coordinate(to: splashCoordinator)
	}
}
