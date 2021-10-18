//
//  EventDetailsViewController.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class EventDetailsViewController: UIViewController {

	@IBOutlet weak var imgvEvent: UIImageView!
	@IBOutlet weak var lblEventName: EABoldLabel!
	@IBOutlet weak var lblEventDescription: EAMediumLabel!
	@IBOutlet weak var lblEventDate: EARegularLabel!
	@IBOutlet weak var lblDescription: EABoldLabel!
	@IBOutlet weak var lblLocation: EABoldLabel!
	@IBOutlet weak var btnFavoriteEvent: UIButton!
	@IBOutlet weak var btnBack: UIButton!
	@IBOutlet weak var mapView: MKMapView!

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
		configureMapView()
		configureMapView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}

}

// MARK: - Setup UI

private extension EventDetailsViewController {

	func setupUI() {
		lblEventName.font = EADesignSystem.Fonts.bold.withSize(21.0)
		lblEventDescription.font = EADesignSystem.Fonts.medium.withSize(16.0)
		lblEventDate.font = EADesignSystem.Fonts.regular.withSize(12.0)
		lblDescription.font = EADesignSystem.Fonts.bold.withSize(18.0)
		lblLocation.font = EADesignSystem.Fonts.bold.withSize(18.0)

		lblEventName.textColor = Colors.titles()
		lblEventDescription.textColor = Colors.subtitles()
		lblEventDate.textColor = Colors.subtitles()
	}
}

// MARK: - Setup Bindings

private extension EventDetailsViewController {

	func setupBindings() {
		viewModel.name
			.bind(to: lblEventName.rx.text)
			.disposed(by: disposeBag)

		viewModel.eventDate
			.bind(to: lblEventDate.rx.text)
			.disposed(by: disposeBag)

		viewModel.description
			.bind(to: lblEventDescription.rx.text)
			.disposed(by: disposeBag)

		viewModel.isFavorited
			.bind(to: btnFavoriteEvent.rx.favorited)
			.disposed(by: disposeBag)

		viewModel.event.isAddedToFavorite
			.bind(to: btnFavoriteEvent.rx.favorited)
			.disposed(by: disposeBag)

		btnFavoriteEvent.rx.tap
			.subscribe(onNext: { [weak self] _ in
				guard let self = self else { return }
				self.viewModel.event.updateFavoriteStatus(event: self.viewModel.event)
			}).disposed(by: disposeBag)

		imgvEvent.setImage(imageURL: viewModel.image.value)

		btnBack.rx.tap.subscribe { [weak self] _ in
			self?.navigationController?.popViewController(animated: true)
		}.disposed(by: disposeBag)
	}
}

// MARK: - Configure MapView

private extension EventDetailsViewController {
	func configureMapView() {
		let initialLocation = CLLocation(latitude: viewModel.eventLatitude.value, longitude: viewModel.eventLongitude.value)
		mapView.centerToLocation(initialLocation)
		let annotation = MKPointAnnotation()
		annotation.coordinate = initialLocation.coordinate
		mapView.addAnnotation(annotation)
	}
}
