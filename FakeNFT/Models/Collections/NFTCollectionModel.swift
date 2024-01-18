//
//  NFTCollectionModel.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 18.01.24.
//

import Foundation

struct NFTModel: Decodable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
