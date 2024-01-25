//
//  UserNetworkModel.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 25.01.24.
//

import Foundation

struct UserNetworkModel: Decodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}
