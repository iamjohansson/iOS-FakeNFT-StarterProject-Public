//
//  CollectionDataProvider.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 24.01.24.
//

import Foundation
import ProgressHUD

// MARK: - Protocol

protocol  CollectionDataProviderProtocol: AnyObject {
    func loadNFTsBy(id: String, completion: @escaping (Result<Nft, Error>) -> Void)
    func updateUserProfile (with profile: ProfileModel)
    func getUserProfile(completion: @escaping (ProfileModel) -> Void)
}

// MARK: - final class

final class CollectionDataProvider: CollectionDataProviderProtocol {
    
    let networkClient: DefaultNetworkClient
    var profile: ProfileModel?
    
    init(networkClient: DefaultNetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadNFTsBy(id: String, completion: @escaping (Result<Nft, Error>) -> Void) {
        ProgressHUD.show()
        networkClient.send(request: NFTGetRequest(id: id), type: Nft.self)  { result in
            completion(result)
        }
        ProgressHUD.dismiss()
    }
    
    func updateUserProfile(with profile: ProfileModel) {
        let updateRequest = ProfileUpdateRequest(profileModel: profile)
        
        networkClient.send(request: updateRequest) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUserProfile(completion: @escaping (ProfileModel) -> Void) { }
}
