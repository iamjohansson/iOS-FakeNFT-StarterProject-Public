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
    func presentCollectionViewData()
    func toggleLikeStatus(model: Nft)
    func toggleCartStatus(model: Nft)
}

// MARK: - Final Class

final class CatalogСollectionPresenter: CatalogСollectionPresenterProtocol {
    weak var viewController: CatalogСollectionViewControllerProtocol?
    private var dataProvider: CollectionDataProvider
    
    let cartController: CartControllerProtocol
    let nftModel: NFTCollection
    var userURL: String?
    var nftArray: [Nft] = []
    var profileModel: [ProfileModel] = []
    
    init(nftModel: NFTCollection, dataProvider: CollectionDataProvider, cartController: CartControllerProtocol) {
        self.nftModel = nftModel
        self.dataProvider = dataProvider
        self.cartController = cartController
    }
    
    func presentCollectionViewData() {
        let viewData = CatalogCollectionViewData(
            coverImageURL: nftModel.cover,
            title: nftModel.name,
            description: nftModel.description,
            authorName: nftModel.author)
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
                    print("loadNFTsError: ", error)
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
    
    func toggleLikeStatus(model: Nft) {
        dataProvider.getUserProfile { [weak self] result in
            switch result {
            case .success(let profileModel):
                let updatedLikes = profileModel.likes?.contains { $0 == model.id } == true ?
                                   profileModel.likes?.filter { $0 != model.id } :
                                   (profileModel.likes ?? []) + [model.id]
                
                let updatedProfileModel = profileModel.update(newLikes: updatedLikes)

                self?.dataProvider.updateUserProfile(with: updatedProfileModel) { updateResult in
                    switch updateResult {
                    case .success(let result):
                        // TODO: Profile updated successfully and (save likes?)
                        print("Profile updated successfully: ", result)
                    case .failure(let error):
                        // TODO: Handle the error if needed
                        print("Error updating profile: \(error)")
                    }
                }
                
            case .failure(let error):
                print("Error getting user profile: \(error)")
            }
        }
    }
    
    func toggleCartStatus(model: Nft) {
        let itemInCart = cartController.cart.contains(where: { $0.id == model.id })
        if itemInCart {
            cartController.removeFromCart(model.id) {
                // TODO: Handle item removal from cart
            }
        } else {
            cartController.addToCart(model) {
                // TODO: Handle item addition to cart
            }
        }
    }
}
