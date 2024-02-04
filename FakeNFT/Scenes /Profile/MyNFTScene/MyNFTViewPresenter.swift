//
//  MyNFTViewPresenter.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 27.01.2024.
//

import Foundation

// MARK: - MyNFT Presenter
final class MyNFTViewPresenter {
    
    // MARK: Properties
    var nftModel: [NFTModel] = []
    var likedNFT: [String]
    var nftId: [String]
    weak var view: MyNFTViewProtocol?
    private var likeTracker: Bool = false
    private let profileService: ProfileServiceProtocol?
    
    // MARK: Initializer
    init(likedNFT: [String], nftId: [String], profileService: ProfileServiceProtocol) {
        self.likedNFT = likedNFT
        self.nftId = nftId
        self.profileService = profileService
    }
    
    // MARK: Methods
    func viewDidLoad() {
        /*
         Определяем какой url используем.
         В test url'е приходит пустой массив nfts, который необновляем из-за проблем бэка
         По сути, в данном сценарии выгружается весь перечень nfts по get-запросу
         Можно сменить base url на mock.api и получать корректные карточки.
         */
        if RequestConstants.baseURL == URLType.test {
            getAllNFTs()
        } else {
            getNFTs()
        }
    }
    
    func filterNFT(type: FilterType) {
        switch type {
        case .price:
            nftModel.sort(by: \.price)
        case .rating:
            nftModel.sort(by: \.rating)
        case .name:
            nftModel.sort(by: \.name)
        }
        view?.update(with: nftModel)
    }
    
    func toggleLike(id: String) {
        if let index = likedNFT.firstIndex(of: id) {
            likedNFT.remove(at: index)
            likeTracker = false
        } else {
            likedNFT.append(id)
            likeTracker = true
        }
        updateLikes()
        view?.update(with: nftModel)
    }
    
    func isLiked(nft: String) -> Bool {
        if likedNFT.firstIndex(of: nft) != nil {
            return true
        } else {
            return false
        }
    }
    
    private func updateLikes() {
        let profileModel = ProfileModelEditing(name: nil, description: nil, website: nil, likes: likedNFT)
        profileService?.updateProfile(profile: profileModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.view?.showSuccess(isLike: self?.likeTracker ?? false)
                    break
                case .failure(let error):
                    self?.view?.showError(error: error)
                }
            }
        }
    }
    
    private func getNFTs() {
        profileService?.loadNFTs { [weak self] result in
            switch result {
            case .success(let nfts):
                self?.nftModel = nfts.filter { self?.nftId.contains($0.id) ?? false }
                let dpGroup = DispatchGroup()
                guard let nftModel = self?.nftModel else { return }
                for nft in nftModel {
                    dpGroup.enter()
                    self?.profileService?.loadUser(userId: nft.author) { result in
                        defer { dpGroup.leave() }
                        switch result {
                        case .success(let user):
                            if let index = nftModel.firstIndex(where: { $0.id == nft.id }) {
                                self?.nftModel[index].authorName = user.name
                            }
                        case .failure(let error):
                            self?.view?.showError(error: error)
                        }
                    }
                }
                dpGroup.notify(queue: .main) {
                    self?.view?.update(with: self?.nftModel ?? [])
                }
            case .failure(let error):
                self?.view?.showError(error: error)
            }
        }
    }
    
    private func getAllNFTs() {
        profileService?.loadAllNfts { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nfts):
                self.nftModel = nfts
                self.view?.update(with: self.nftModel)
            case .failure(let error):
                self.view?.showError(error: error)
            }
        }
    }
}

// MARK: - Enum cases for filter
extension MyNFTViewPresenter {
    enum FilterType {
        case price
        case rating
        case name
    }
}
