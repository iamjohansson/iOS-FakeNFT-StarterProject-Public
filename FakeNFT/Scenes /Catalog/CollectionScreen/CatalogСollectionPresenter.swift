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
    weak var viewController: CatalogСollectionViewControllerProtocol?
    private var dataProvider: CollectionDataProvider
    
    let nftModel: NFTCollection
    var userURL: String?
    var nftArray: [Nft] = []
    var profileModel: [ProfileModel] = []
    
    init(nftModel: NFTCollection, dataProvider: CollectionDataProvider) {
        self.nftModel = nftModel
        self.dataProvider = dataProvider
    }
    
    private func presentCollectionViewData(authorName: String) {
        let viewData = CatalogCollectionViewData(
            coverImageURL: nftModel.cover,
            title: nftModel.name,
            description: nftModel.description,
            authorName: authorName)
        viewController?.renderViewData(viewData: viewData)
    }
    
    func loadNFTs() {
        var nftArray: [Nft] = []
        let group = DispatchGroup()
        
        for nft in nftModel.nfts {
            group.enter()
            dataProvider.loadNFTsBy(id: nft) { result in
                switch result {
                case .success(let data):
                    nftArray.append(data)
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        group.wait()
        group.notify(queue: .main) {
            self.nftArray = nftArray
            self.viewController?.reloadCollectionView()
        }
    }
    
    func loadAuthorWebsite() {
    }
    
    func toggleLikeStatus(model: Nft) {
        dataProvider.getUserProfile { [weak self] profileModel in
            let isLiked = profileModel.likes?.contains { $0 == model.id }
            var updatedProfileModel = profileModel
            if isLiked ?? false {
                updatedProfileModel.likes?.removeAll { $0 == model.id }
            } else {
                updatedProfileModel.likes?.append(model.id)
            }
            self?.dataProvider.updateUserProfile(with: updatedProfileModel)
        }
    }
    
    func toggleCartStatus(model: Nft) { }
}

