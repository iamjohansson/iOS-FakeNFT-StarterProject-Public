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
}

// MARK: - final class

final class CollectionDataProvider: CollectionDataProviderProtocol {
    
    let networkClient: DefaultNetworkClient
    
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
}
