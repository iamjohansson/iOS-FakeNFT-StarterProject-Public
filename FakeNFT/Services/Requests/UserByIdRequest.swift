//
//  UserByIdRequest.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 25.01.24.
//

import Foundation

struct UserByIdRequest: NetworkRequest {
    var endpoint: URL?
    
    init(id: String) {
        guard let endpoint = URL(string:
            "\(RequestConstants.baseURL)/api/v1/users/\(id)") else { return }
        self.endpoint = endpoint
    }
}

