//
//  EALabel.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit

final class EABoldLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.customizeLabel()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.customizeLabel()
	}

	private func customizeLabel() {
		self.font = EADesignSystem.Fonts.bold
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.8
	}
}

final class EAMediumLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.customizeLabel()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.customizeLabel()
	}

	private func customizeLabel() {
		self.font = EADesignSystem.Fonts.medium
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.8
	}
}

final class EARegularLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.customizeLabel()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.customizeLabel()
	}

	private func customizeLabel() {
		self.font = EADesignSystem.Fonts.regular
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.5
	}
}
