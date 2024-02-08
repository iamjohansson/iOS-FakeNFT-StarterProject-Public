//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 16.01.2024.
//

import Foundation

typealias ProfileCompletion = (Result<ProfileModels, Error>) -> Void

protocol ProfileServiceProtocol {
    func loadProfile(completion: @escaping ProfileCompletion)
    func updateProfile(profile: ProfileModelEditing, completion: @escaping (Result<ProfileModels, Error>) -> Void)
    func loadNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void)
    func loadUser(userId: String, completion: @escaping (Result<UserModel, Error>) -> Void)
    func loadAllNfts(completion: @escaping (Result<[NFTModel], Error>) -> Void)
}

final class ProfileService: ProfileServiceProtocol {

    private let networkClient: NetworkClient
    private let storage: ProfileStorage

    init(networkClient: NetworkClient = DefaultNetworkClient(), storage: ProfileStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }
    
    func loadProfile(completion: @escaping ProfileCompletion) {
        
        let request = ProfileRequest()
        networkClient.send(request: request, type: ProfileModels.self) { [weak storage] result in
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
        let request = ProfilePutRequest(profileModel: profile)
        networkClient.send(request: request, type: ProfileModels.self) { [weak storage] result in
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
    
    func loadAllNfts(completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        let request = NFTRequestForProfile()
        networkClient.send(request: request, type: [NFTModel].self) { result in
            switch result {
            case .success(let nfts):
                completion(.success(nfts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
