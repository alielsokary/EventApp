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

/// Shows a list of  events and event types.
class EventsViewController: UIViewController {

	// MARK: - Outlets

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var collectionView: UICollectionView!

	// MARK: - Properties

	private let viewModel: EventsViewModel!
	private let disposeBag = DisposeBag()

	private let refreshControl = UIRefreshControl()

	private let eventTypeNib = Nib.eventTypeCollectionViewCell
	private let idEventTypeCell = ReuseIdentifier.eventTypeCollectionViewCell.identifier

	private let nib = Nib.eventTableViewCell
	private let idEventCell = ReuseIdentifier.eventTableViewCell.identifier

	// MARK: - Initializer

	required init?(coder: NSCoder, viewModel: EventsViewModel) {
		self.viewModel = viewModel
		super.init(coder: coder)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		configureTableView()
		configureCollectionView()
		setupBindings()
		selectionBindings()
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

// MARK: - CollectionView Configurations

private extension EventsViewController {

	func configureCollectionView() {
		collectionView.backgroundColor = .clear
		collectionView.register(Nib.eventTypeCollectionViewCell)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = nil
		collectionView.delegate = nil
		collectionView.rx.setDelegate(self)
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

		viewModel.evetTypes
			.observe(on: MainScheduler.instance)
			.bind(to: collectionView.rx.items(cellIdentifier: idEventTypeCell, cellType: EventTypeCollectionViewCell.self)) { _, viewModel, cell in
				cell.viewModel = viewModel
			}.disposed(by: disposeBag)

		viewModel.events
			.observe(on: MainScheduler.instance)
			.do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
			.bind(to: tableView.rx.items(cellIdentifier: idEventCell, cellType: EventTableViewCell.self)) { _, viewModel, cell in
				cell.viewModel = viewModel
			}.disposed(by: disposeBag)

		viewModel.alertMessage
			.subscribe(onNext: { [weak self] in self?.showMessage($0) })
			.disposed(by: disposeBag)

		viewModel.isLoading
			.subscribe { [weak self] isLoading in
				isLoading ? self?.startLoading() : self?.endLoading()
			}.disposed(by: disposeBag)

		tableView.rx.didScroll.subscribe { [weak self] _ in
			guard let self = self else { return }
			let offSetY = self.tableView.contentOffset.y
			let contentHeight = self.tableView.contentSize.height

			if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
				self.viewModel.fetchPaginatedData.onNext(())
			}
		}.disposed(by: disposeBag)
	}

	func selectionBindings() {
		collectionView.rx.modelSelected(EventTypeViewModel.self)
			.bind(to: viewModel.selectedEventType)
			.disposed(by: disposeBag)

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

// MARK: - CollectionView Flow Layout

extension EventsViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 120.0, height: 40.0)
	}
}
