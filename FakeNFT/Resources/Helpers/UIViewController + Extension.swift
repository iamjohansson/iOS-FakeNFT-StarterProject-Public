//
//  UIViewController + Extension.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 05.02.2024.
//

import UIKit

extension UIViewController {
    func addSwipeToPreviousViewControllerGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToPreviousViewController))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func swipeToPreviousViewController() {
        navigationController?.popViewController(animated: true)
    }
}
