//
//  AppConfiguration.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 15.01.24.
//

import UIKit

final class AppConfiguration {
    let profileViewController: UIViewController
    let catalogViewController: UIViewController
    let cartViewController: UIViewController?
    let statisticViewController: UIViewController?
    private let catalogNavigationController: UINavigationController
    
    init() {
        let networkClient = DefaultNetworkClient()
        let storage = ProfileStorage()
        let profileService = ProfileService(networkClient: networkClient, storage: storage)
        let profilePresenter = ProfileViewPresenter(profileService: profileService)
        
        profileViewController = ProfileViewController(presenter: profilePresenter)
        
        let dataProvider = CatalogDataProvider(networkClient: DefaultNetworkClient())
        let catalogPresenter = CatalogPresenter(dataProvider: dataProvider)
        
        catalogViewController = CatalogViewController(presenter: catalogPresenter)
        catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
        
        cartViewController = UIViewController()
        statisticViewController = UIViewController()
    }
}
