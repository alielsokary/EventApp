//
//  EventTableViewCell.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit
import RxSwift

class EventTableViewCell: UITableViewCell {

	@IBOutlet weak var imgvEvent: UIImageView!
	@IBOutlet weak var lblEventName: EABoldLabel!
	@IBOutlet weak var lblEventDescription: EAMediumLabel!
	@IBOutlet weak var lblEventDate: EARegularLabel!
	@IBOutlet weak var btnFavoriteEvent: UIButton!

	private let filledIcon = Images.starFilledIcon()?.withTintColor(Colors.gold()!)
	private let unfilledIcon = Images.starUnfilledIcon()?.withTintColor(Colors.gold()!)
	private var disposeBag = DisposeBag()

	override func awakeFromNib() {
        super.awakeFromNib()
		setupUI()
    }

	override func prepareForReuse() {
		super.prepareForReuse()
		disposeBag = DisposeBag()
	}

	// MARK: - Properties
	var viewModel: EventViewModel! {
		didSet {
			self.configure()
			self.setupBinding()
		}
	}

}

// MARK: - SetupUI

extension EventTableViewCell {

	func setupUI() {
		self.selectionStyle = .none
		lblEventName.textColor = Colors.titles()
		lblEventDescription.textColor = Colors.subtitles()
		lblEventDate.textColor = Colors.subtitles()
		btnFavoriteEvent.setImage(unfilledIcon, for: .normal)
	}
}

// MARK: - Setup Binding

extension EventTableViewCell {

	func setupBinding() {
		viewModel.isFavorited
			.bind(to: btnFavoriteEvent.rx.favorited)
			.disposed(by: disposeBag)

		btnFavoriteEvent.rx.tap
			.subscribe(onNext: { [weak self] _ in
				guard let self = self else { return }
				self.viewModel.updateFavoriteStatus(event: self.viewModel)
			}).disposed(by: disposeBag)
	}
}

// MARK: - Configure

extension EventTableViewCell {

	func configure() {
		lblEventName.text = viewModel.name
		lblEventDescription.text = viewModel.eventDescription
		lblEventDate.text = viewModel.startDate?.formatedShortDate
		imgvEvent.setImage(imageURL: viewModel.cover ?? "")
	}
}
