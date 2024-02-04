//
//  NFTTableViewRequest.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 16.01.24.
//

import Foundation

struct NFTTableViewRequest: NetworkRequest {
    var endpoint: URL?

    init() {
        guard let endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/collections") else { return }
        self.endpoint = endpoint
    }
}
