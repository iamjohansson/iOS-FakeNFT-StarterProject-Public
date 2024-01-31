//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 24.01.24.
//

import Foundation

struct ProfileModel: Codable {
    let name: String?
    let description: String?
    let website: String?
    let nfts: [String]?
    let likes: [String]?
    let id: String
    
    func update(newLikes: [String]?) -> ProfileModel {
        .init(
            name: name,
            description: description,
            website: website,
            nfts: nfts,
            likes: newLikes ?? likes,
            id: id
        )
    }
}
