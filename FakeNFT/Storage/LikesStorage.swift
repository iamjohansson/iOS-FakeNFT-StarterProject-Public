//
//  LikesStorage.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 28.01.24.
//

import Foundation

final class LikesStorage {
    static let shared = LikesStorage()
    var likes: [String] = []

    private init() {}
}

