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

		Observable.just([])
			.delay(.seconds(2), scheduler: MainScheduler.instance)
			.subscribe { [weak self] _ in
				guard let self = self else { return }
				self.coordinateToEventsList()
					.subscribe()
					.dispose()
		}.disposed(by: disposeBag)

		return Observable.empty()
	}

	private func coordinateToEventsList() -> Observable<Void> {
		let eventsCoordinator = EventsCoordinator(rootViewController: rootViewController)
		return coordinate(to: eventsCoordinator)
			.map { _ in () }
	}
}
