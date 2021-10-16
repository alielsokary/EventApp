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
	@IBOutlet weak var lblEventName: UILabel!
	@IBOutlet weak var lblEventDescription: UILabel!
	@IBOutlet weak var lblEventDate: UILabel!
	@IBOutlet weak var btnFavoriteEvent: UIButton!

	override func awakeFromNib() {
        super.awakeFromNib()
    }

	// MARK: - Properties
	var viewModel: EventViewModel! {
		didSet {
			self.configure()
		}
	}

}

extension EventTableViewCell {

	func configure() {
		lblEventName.text = viewModel.name
		lblEventDescription.text = viewModel.eventDescription
		lblEventDate.text = viewModel.startDate?.formatedShortDate
		imgvEvent.setImage(imageURL: viewModel.cover)
	}
}
