//
//  ProfileViewPresenter.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 16.01.2024.
//

import Foundation

protocol ProfileViewPresenterProtocol {
    var delegate: ProfileViewControllerDelegate? { get set }
    var model: ProfileModels? { get }
    var profileService: ProfileServiceProtocol { get }
    func viewDidLoad()
    func saveInModel(profileModel: ProfileModels)
    func getLikeArray() -> [String]
    func getNftIdArray() -> [String]
}

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    
    internal weak var delegate: ProfileViewControllerDelegate?
    internal var profileService: ProfileServiceProtocol
    private (set) var model: ProfileModels? = nil
    
    init(profileService: ProfileServiceProtocol) {
        self.profileService = profileService
    }
    
    func viewDidLoad() {
        getProfile()
    }
    
    func saveInModel(profileModel: ProfileModels) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let profileUIModel = ProfileModels(
                name: profileModel.name,
                avatar: profileModel.avatar,
                description: profileModel.description,
                website: profileModel.website,
                nfts: profileModel.nfts,
                likes: profileModel.likes,
                id: profileModel.id
            )
            self?.model = profileUIModel
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.update()
            }
        }
    }
    
    func getLikeArray() -> [String] {
        return model?.likes ?? []
    }
    
    func getNftIdArray() -> [String] {
        return model?.nfts ?? []
    }
    
    private func getProfile() {
        self.delegate?.showLoading()
        profileService.loadProfile() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.delegate?.hideLoading()
                    self?.saveInModel(profileModel: profile)
                case .failure(let error):
                    self?.delegate?.showError(error: error)
                }
            }
        }
    }
}
