//
//  OrderModel.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 03.02.24.
//

import Foundation

struct OrderModel: Codable {
    let nfts: [String]?
    let id: String
    
    func update(newNfts: [String]? = nil) -> OrderModel {
        .init(
            nfts: newNfts ?? nfts,
            id: id
        )
    }
}
