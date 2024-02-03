//
//  NFTRequest.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 29.01.2024.
//

import Foundation

struct NFTRequestForProfile: NetworkRequest {
    var endpoint: URL? {
        return URL(string: "\(RequestConstants.baseURL)/api/v1/nft")
    }

    var httpMethod: HttpMethod {
        return .get
    }
}

struct UserRequest: NetworkRequest {
    let userId: String
    
    var endpoint: URL? {
            return URL(string: "\(RequestConstants.baseURL)/api/v1/users/\(userId)")
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
}

