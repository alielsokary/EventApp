//
//  EADesignSystem.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit

struct EADesignSystem {

	// MARK: Colors

	struct Colors {
		static let primary: UIColor = .primary
		static let background: UIColor = .background
		static let gold: UIColor = .gold
		static let titles: UIColor = .titles
		static let subtitles: UIColor = .subtitles
	}

	// MARK: Fonts

	struct Fonts {
		static let bold: UIFont = .textStyleBold
		static let medium: UIFont = .textStyleMedium
		static let regular: UIFont = .textStyleRegular
	}
}

// MARK: - UIFont+Extension

extension UIFont {
	class var textStyleBold: UIFont {
		return Fonts.robotoBlack(size: 16.0)!
	}

	class var textStyleMedium: UIFont {
		return Fonts.robotoMedium(size: 18.0)!
	}

	class var textStyleRegular: UIFont {
		return Fonts.robotoRegular(size: 12.0)!
	}
}

// MARK: - UIColor+Extension

extension UIColor {
	@nonobjc class var primary: UIColor {
		return Colors.primary()!
	}

	@nonobjc class var background: UIColor {
		return Colors.background()!
	}

	@nonobjc class var gold: UIColor {
		return Colors.gold()!
	}

	@nonobjc class var titles: UIColor {
		return Colors.titles()!
	}

	@nonobjc class var subtitles: UIColor {
		return R.color.subtitles()!
	}
}
