//
//  EventTableViewCell.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit

class EventTableViewCell: UITableViewCell {

	@IBOutlet weak var imgvEvent: UIImageView!
	@IBOutlet weak var lblEventName: EABoldLabel!
	@IBOutlet weak var lblEventDescription: EAMediumLabel!
	@IBOutlet weak var lblEventDate: EARegularLabel!
	@IBOutlet weak var btnFavoriteEvent: UIButton!

	override func awakeFromNib() {
        super.awakeFromNib()
		setupUI()
    }

	// MARK: - Properties
	var viewModel: EventViewModel! {
		didSet {
			self.configure()
		}
	}

}

// MARK: - SetupUI

extension EventTableViewCell {

	func setupUI() {
		lblEventName.textColor = Colors.titles()
		lblEventDescription.textColor = Colors.subtitles()
		lblEventDate.textColor = Colors.subtitles()
	}
}

// MARK: - Configure

extension EventTableViewCell {

	func configure() {
		lblEventName.text = viewModel.name
		lblEventDescription.text = viewModel.eventDescription
		lblEventDate.text = viewModel.startDate?.formatedShortDate
		imgvEvent.setImage(imageURL: viewModel.cover)
	}
}
