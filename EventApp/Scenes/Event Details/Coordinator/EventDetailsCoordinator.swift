//
//  EventDetailsCoordinator.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit
import RxSwift

class EventDetailsCoordinator: BaseCoordinator<Void> {

	private let rootViewController: UIViewController
	private let eventItemViewModel: EventViewModel!
	private let viewControllerIdentifier = Storyboard.main.eventDetailsViewController.identifier

	init(rootViewController: UIViewController, viewModel: EventViewModel) {
		self.rootViewController = rootViewController
		self.eventItemViewModel = viewModel
	}

	override func start() -> Observable<Void> {
		let viewModel = EventDetailsViewModel(event: eventItemViewModel)
		let viewController = Storyboard.main().instantiateViewController(identifier: viewControllerIdentifier) { coder in
			return EventDetailsViewController(coder: coder, viewModel: viewModel)
		}
		rootViewController.navigationController?.pushViewController(viewController, animated: true)
		return Observable.empty()
	}
}
