//
//  EventTypeCollectionViewCell.swift
//  EventApp
//
//  Created by Ali Elsokary on 19/10/2021.
//  
//

import UIKit

class EventTypeCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var lblEventType: EABoldLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
		setupUI()
    }

	// MARK: - Properties
	var viewModel: EventTypeViewModel! {
		didSet {
			self.configure()
		}
	}

}

// MARK: - SetupUI

extension EventTypeCollectionViewCell {

	func setupUI() {
		lblEventType.textColor = Colors.titles()
	}
}

// MARK: - Configure

extension EventTypeCollectionViewCell {

	func configure() {
		lblEventType.text = viewModel.name
	}
}
