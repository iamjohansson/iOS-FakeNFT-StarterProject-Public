//
//  ProfileStorage.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 16.01.2024.
//

import Foundation

protocol ProfileStorageProtocol: AnyObject {
    func saveProfile(_ profile: ProfileModels)
    func getProfile() -> ProfileModels?
}

final class ProfileStorage: ProfileStorageProtocol {
    private var profile: ProfileModels?

    private let syncQueue = DispatchQueue(label: "sync-profile-queue")
    
    func saveProfile(_ profile: ProfileModels) {
        syncQueue.async { [weak self] in
            self?.profile = profile
        }
    }
    
    func getProfile() -> ProfileModels? {
        syncQueue.sync { [weak self] in
            return self?.profile
        }
    }
}
