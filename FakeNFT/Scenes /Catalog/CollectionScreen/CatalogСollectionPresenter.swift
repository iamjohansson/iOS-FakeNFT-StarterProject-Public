//
//  CatalogСollectionPresenter.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 23.01.24.
//

import Foundation

// MARK: - Protocol

protocol CatalogСollectionPresenterProtocol: AnyObject {
    var viewController: CatalogСollectionViewControllerProtocol? { get set }
    var userURL: String? { get }
    var nftArray: [Nft] { get }
    func loadNFTs()
    func loadAuthorWebsite()
    func toggleLikeStatus(model: Nft)
    func toggleCartStatus(model: Nft)
}

// MARK: - Final Class

final class CatalogСollectionPresenter: CatalogСollectionPresenterProtocol {
    func loadNFTs() {
        var nftArray: [Nft] = []
    }
    
    func toggleLikeStatus(model: Nft) {
        <#code#>
    }
    
    func toggleCartStatus(model: Nft) {
        <#code#>
    }
    
    
    weak var viewController: CatalogСollectionViewControllerProtocol?
    
    let nftModel: NFTCollection
    var userURL: String?
    var nftArray: [Nft] = []
    
    
    init(nftModel: NFTCollection) {
        self.nftModel = nftModel
    }
    
    private func presentCollectionViewData(authorName: String) {
        let viewData = CatalogCollectionViewData(
            coverImageURL: nftModel.cover,
            title: nftModel.name,
            description: nftModel.description,
            authorName: authorName)
        viewController?.renderViewData(viewData: viewData)
    }
    
    func loadAuthorWebsite() {
        let id = nftModel.author
    }
}

