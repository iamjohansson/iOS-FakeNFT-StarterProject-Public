//
//  CatalogPresenter.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 17.01.24.
//

import Foundation

// MARK: - Protocol

protocol CatalogPresenterProtocol: AnyObject {
    var dataSource: [NFTCollection] { get }
    var viewController: CatalogViewControllerProtocol? { get set }
    func fetchCollections()
    func sortNFTS(by: NFTCollectionsSortOptions)
}

// MARK: - Final Class

final class CatalogPresenter: CatalogPresenterProtocol {

    weak var viewController: CatalogViewControllerProtocol?
    private var dataProvider: CatalogDataProviderProtocol

    var dataSource: [NFTCollection] {
        dataProvider.NFTCollections
    }

    init(dataProvider: CatalogDataProviderProtocol) {
        self.dataProvider = dataProvider
    }


    func fetchCollections() {
        dataProvider.fetchNFTCollection { [weak self] in
            self?.viewController?.reloadTableView()
        }
    }

    func sortNFTS(by: NFTCollectionsSortOptions) {
        dataProvider.sortNFTCollections(by: by)
    }
}

