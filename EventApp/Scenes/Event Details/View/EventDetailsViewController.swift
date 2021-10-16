//
//  EventDetailsViewController.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit
import RxSwift
import RxCocoa

class EventDetailsViewController: UIViewController {

	@IBOutlet weak var lblEventName: EABoldLabel!

	private let viewModel: EventDetailsViewModel
	private let disposeBag = DisposeBag()

	required init?(coder: NSCoder, viewModel: EventDetailsViewModel) {
		self.viewModel = viewModel
		super.init(coder: coder)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupBindings()
	}

}

// MARK: - Setup UI

private extension EventDetailsViewController {

	func setupUI() {

	}
}

// MARK: - Setup Bindings

private extension EventDetailsViewController {

	func setupBindings() {
		viewModel.name
			.bind(to: lblEventName.rx.text)
			.disposed(by: disposeBag)
	}
}
