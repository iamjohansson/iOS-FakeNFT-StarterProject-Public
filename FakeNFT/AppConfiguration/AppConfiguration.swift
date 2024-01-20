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
        let networkClient = DefaultNetworkClient()
        let dataProvider = CatalogDataProvider(networkClient: DefaultNetworkClient())
        let catalogPresenter = CatalogPresenter(dataProvider: dataProvider)
        
        catalogViewController = CatalogViewController(presenter: catalogPresenter)
        catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
    }
}
