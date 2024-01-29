//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 16.01.2024.
//

import Foundation

typealias ProfileCompletion = (Result<ProfileModel, Error>) -> Void

protocol ProfileServiceProtocol {
    func loadProfile(completion: @escaping ProfileCompletion)
    func updateProfile(profile: ProfileModelEditing, completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func loadNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void)
    func loadUser(userId: String, completion: @escaping (Result<UserModel, Error>) -> Void)
}

final class ProfileService: ProfileServiceProtocol {

    private let networkClient: NetworkClient
    private let storage: ProfileStorage

    init(networkClient: NetworkClient = DefaultNetworkClient(), storage: ProfileStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadProfile(completion: @escaping ProfileCompletion) {
        if let profile = storage.getProfile() {
            completion(.success(profile))
            return
        }
        
        let request = ProfileRequest()
        networkClient.send(request: request, type: ProfileModel.self) { [weak storage] result in
            switch result {
            case .success(let profile):
                storage?.saveProfile(profile)
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateProfile(profile: ProfileModelEditing, completion: @escaping ProfileCompletion) {
        let request = ProfileUpdateRequest(profileModel: profile)
        networkClient.send(request: request, type: ProfileModel.self) { [weak storage] result in
            switch result {
            case .success(let profile):
                storage?.saveProfile(profile)
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        let request = NFTRequestForProfile()
        networkClient.send(request: request, type: [NFTModel].self, onResponse: completion)
    }
    
    func loadUser(userId: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        let request = UserRequest(userId: userId)
        networkClient.send(request: request, type: UserModel.self, onResponse: completion)
    }
}
