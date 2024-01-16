//
//  CatalogDataProvider.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 16.01.24.
//

import Foundation
import ProgressHUD

// MARK: - Protocol

protocol CatalogDataProviderProtocol: AnyObject {
    func sortNFTCollections(by: NFTCollectionsSortOptions)
    var NFTCollections: [NFTCollection] { get }
}

// MARK: - Final Class

final class CatalogDataProvider: CatalogDataProviderProtocol {
    var NFTCollections: [NFTCollection] = []
    
    func sortNFTCollections(by: NFTCollectionsSortOptions) {
        switch by {
        case .name:
            NFTCollections.sort { $0.name < $1.name }
        case .nftCount:
            NFTCollections.sort { $0.nftCount < $1.nftCount }
        }
    }
}
