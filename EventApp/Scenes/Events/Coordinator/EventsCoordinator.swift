//
//  EventsCoordinator.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import RxSwift

class EventsCoordinator: BaseCoordinator<Void> {

	private let rootViewController: UIViewController
	private let service = EventsServiceImpl()

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	override func start() -> Observable<Void> {
		let viewModel = EventsViewModel(service: service)
		let viewController = Storyboard.main().instantiateViewController(identifier: Storyboard.main.eventsViewController.identifier) { coder in
			return EventsViewController(coder: coder, viewModel: viewModel)
		}

		viewModel.selectedEvent
			.flatMap({ [unowned self] (event) in
			self.coordinateToEventDetails(with: event)
			})
			.subscribe()
			.disposed(by: disposeBag)

		rootViewController.navigationController?.pushViewController(viewController, animated: false)

		return Observable.empty()
	}

	private func coordinateToEventDetails(with viewModel: EventViewModel) -> Observable<Void> {
		let eventDetailsCoordinator = EventDetailsCoordinator(rootViewController: rootViewController, viewModel: viewModel)
		return coordinate(to: eventDetailsCoordinator)
			.map { _ in () }

	}
}
