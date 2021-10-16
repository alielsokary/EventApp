//
//  EventsViewController.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import UIKit
import RxSwift
import RxCocoa

class EventsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	private let viewModel: EventsViewModel!
	private let disposeBag = DisposeBag()

	private let nib = Nib.eventTableViewCell
	private let cellIdentifier = ReuseIdentifier.eventTableViewCell.identifier

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
		configureTableView()
		setupBindings()
		selectionBindings()

    }

}

// MARK: - Setup UI

private extension EventsViewController {

	func setupUI() {
		self.navigationItem.setHidesBackButton(true, animated: true)
		viewModel.title
			.bind(to: self.rx.title)
			.disposed(by: disposeBag)
	}
}

// MARK: - TableView Configurations

private extension EventsViewController {

	func configureTableView() {
		tableView.separatorStyle = .none
		tableView.estimatedRowHeight = 250
		tableView.register(nib)
		tableView.dataSource = nil
		tableView.delegate = nil
		tableView.rx.setDelegate(self)
			.disposed(by: disposeBag)
	}
}

// MARK: - Setup Bindings

private extension EventsViewController {

	func setupBindings() {
		viewModel.events
			.observe(on: MainScheduler.instance)
			.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: EventTableViewCell.self)) { _, viewModel, cell in
				cell.viewModel = viewModel
			}.disposed(by: disposeBag)

		viewModel.start()
	}

	func selectionBindings() {
		tableView.rx.modelSelected(EventViewModel.self)
			.bind(to: viewModel.selectedEvent)
			.disposed(by: disposeBag)
	}
}

// MARK: - TableView Delegate

extension EventsViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

}