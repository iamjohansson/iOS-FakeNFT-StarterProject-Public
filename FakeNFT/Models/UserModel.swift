//
//  UserModel.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 25.01.24.
//

import Foundation

struct UserModel {
    let name: String
    let website: String
    let id: String
    
    init(with user: UserNetworkModel) {
        self.name = user.name
        self.website = user.website
        self.id = user.id
    }
}
