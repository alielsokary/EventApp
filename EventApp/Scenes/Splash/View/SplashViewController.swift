//
//  SplashViewController.swift
//  EventApp
//
//  Created by Ali Elsokary on 15/10/2021.
//  
//

import UIKit

class SplashViewController: UIViewController {

	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()

	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}

}
