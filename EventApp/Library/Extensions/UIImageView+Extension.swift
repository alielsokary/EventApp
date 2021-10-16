//
//  UIImageView+Extension.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import UIKit
import Kingfisher

extension UIImageView {
	func setImage(imageURL: String?) {
		self.kf.setImage(with: URL(string: imageURL ?? ""), placeholder: Images.placeholderIcon())
	}
}
