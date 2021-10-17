//
//  LoadingIndicatorType.swift
//  EventApp
//
//  Created by Ali Elsokary on 17/10/2021.
//  
//

import UIKit
import PKHUD

protocol LoadingIndicatorType: UIViewController {}

extension LoadingIndicatorType {

	func startLoading() {
		HUD.show(.progress)
	}

	func endLoading() {
		HUD.hide()
	}

	func showMessage(_ message: String) {
		HUD.flash(.labeledError(title: nil, subtitle: message), delay: 1.5)
	}
}

extension UIViewController: LoadingIndicatorType {}
