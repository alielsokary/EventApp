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
	private let refreshControl = UIRefreshControl()

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
		refreshControl.sendActions(for: .valueChanged)
	}

}

// MARK: - Setup UI

private extension EventsViewController {

	func setupUI() {
		self.view.backgroundColor = Colors.background()
		self.navigationItem.setHidesBackButton(true, animated: true)
		tableView.insertSubview(refreshControl, at: 0)
	}
}

// MARK: - TableView Configurations

private extension EventsViewController {

	func configureTableView() {
		tableView.separatorStyle = .none
		tableView.backgroundColor = .clear
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

		viewModel.title
			.bind(to: self.rx.title)
			.disposed(by: disposeBag)

		refreshControl.rx.controlEvent(.valueChanged)
			.bind(to: viewModel.reload)
			.disposed(by: disposeBag)

		viewModel.events
			.observe(on: MainScheduler.instance)
			.do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
			.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: EventTableViewCell.self)) { _, viewModel, cell in
				cell.viewModel = viewModel
			}.disposed(by: disposeBag)

		viewModel.alertMessage
			.subscribe(onNext: { [weak self] in self?.showMessage($0) })
			.disposed(by: disposeBag)

		viewModel.isLoading
			.subscribe { [weak self] isLoading in
				isLoading ? self?.startLoading() : self?.endLoading()
			}.disposed(by: disposeBag)
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
		return 160
	}

}
