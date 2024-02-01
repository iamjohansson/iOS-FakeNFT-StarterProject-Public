//
//  FavoritesNFTViewPresenter.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 30.01.2024.
//

import Foundation

protocol FavoritesNFTViewPresenterProtocol: AnyObject {
    var view: FavoriteNFTViewProtocol? { get set }
    var nftModelWithLike: [NFTModel] { get }
    func viewDidLoad()
    func toggleLike(nft: NFTModel)
}

final class FavoritesNFTViewPresenter: FavoritesNFTViewPresenterProtocol {
    
    weak var view: FavoriteNFTViewProtocol?
    var nftModelWithLike: [NFTModel] = []
    private let profileService: ProfileServiceProtocol
    private var likedNFT: [String]
    
    init(profileService: ProfileServiceProtocol, likedNFT: [String]) {
        self.profileService = profileService
        self.likedNFT = likedNFT
    }

    func viewDidLoad() {
        getLikes()
    }
    
    func toggleLike(nft: NFTModel) {
        if let index = likedNFT.firstIndex(of: nft.id) {
            likedNFT.remove(at: index)
            nftModelWithLike.removeAll { $0.id == nft.id }
        } else {
            likedNFT.append(nft.id)
            nftModelWithLike.append(nft)
        }
        updateLikes()
        view?.update(with: nftModelWithLike)
    }
    
    private func updateLikes() {
        let profileModel = ProfileModelEditing(name: nil, description: nil, website: nil, likes: likedNFT)
        profileService.updateProfile(profile: profileModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.view?.showSuccess()
                    break
                case .failure(let error):
                    self?.view?.showError(error: error)
                }
            }
        }
    }
    
    private func getLikes() {
        profileService.loadNFTs { [weak self] result in
            switch result {
            case .success(let nfts):
                let nftModelWithLike = nfts.filter { self?.likedNFT.contains($0.id) ?? false }
                self?.nftModelWithLike = nftModelWithLike
                self?.view?.update(with: nftModelWithLike)
            case .failure(let error):
                self?.view?.showError(error: error)
            }
        }
    }
}
