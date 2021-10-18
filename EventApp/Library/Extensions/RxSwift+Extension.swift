//
//  RxSwift+Extension.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit
import RxSwift

// MARK: - UIButton
extension Reactive where Base: UIButton {
	public var favorited: Binder<Bool> {
		let starFilledIcon = Images.starFilledIcon()?.withTintColor(Colors.gold()!)
		let starUnfilledIcon = Images.starUnfilledIcon()?.withTintColor(Colors.gold()!)
		return Binder(self.base) { button, valid in
			valid ? button.setImage(starFilledIcon, for: .normal) : button.setImage(starUnfilledIcon, for: .normal)
		}
	}
}
