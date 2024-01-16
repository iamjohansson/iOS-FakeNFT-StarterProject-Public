//
//  AppConfiguration.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 15.01.24.
//

import UIKit

final class AppConfiguration {
    let catalogViewController: UIViewController
    let catalogNavigationController: UINavigationController
    
    init() {
        catalogViewController = CatalogViewController()
        catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
    }
}
