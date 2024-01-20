//
//  NFTCollection.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 16.01.24.
//

import Foundation

struct NFTCollection: Decodable {
    let name: String
    let cover: String
    let nfts: [String]
    let id: String
    let description: String
    let author: String
}
