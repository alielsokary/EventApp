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
		return Binder(self.base) { button, valid in
			button.imageView?.image = valid ? Images.starFilledIcon()?.withTintColor(Colors.gold()!) : Images.starUnfilledIcon()?.withTintColor(Colors.gold()!)
		}
	}
}
