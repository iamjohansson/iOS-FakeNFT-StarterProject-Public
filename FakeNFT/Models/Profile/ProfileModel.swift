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
    var likes: [String]?
    let id: String
}
