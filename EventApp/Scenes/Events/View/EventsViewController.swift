//
//  EventsViewController.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import UIKit

class EventsViewController: UIViewController {

	private let viewModel: EventsViewModel!

	required init?(coder: NSCoder, viewModel: EventsViewModel) {
		self.viewModel = viewModel
		super.init(coder: coder)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()

    }

}

// MARK: - Setup UI

private extension EventsViewController {

	func setupUI() {
		self.navigationItem.setHidesBackButton(true, animated: true)
	}
}
