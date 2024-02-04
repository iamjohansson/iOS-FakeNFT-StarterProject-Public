//
//  AppConfiguration.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 15.01.24.
//

import UIKit

final class AppConfiguration {
    let profileViewControlle: UIViewController
    let catalogViewController: UIViewController
    private let catalogNavigationController: UINavigationController
    private let cartService: CartControllerProtocol
    
    init() {
        let networkClient = DefaultNetworkClient()
        let storage = ProfileStorage()
        let profileService = ProfileService(networkClient: networkClient, storage: storage)
        let profilePresenter = ProfileViewPresenter(profileService: profileService)
        
        profileViewControlle = ProfileViewController(presenter: profilePresenter)
        
        let dataProvider = CatalogDataProvider(networkClient: DefaultNetworkClient())
        let catalogPresenter = CatalogPresenter(dataProvider: dataProvider)
        cartService = CartService()
        
        catalogViewController = CatalogViewController(presenter: catalogPresenter, cartService: cartService)
        catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
    }
}
