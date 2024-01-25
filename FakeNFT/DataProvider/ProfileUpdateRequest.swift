//
//  ProfileUpdateRequest.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 25.01.24.
//

import Foundation

struct ProfileUpdateRequest: NetworkRequest {
    
    let profileModel: ProfileModel
    
    var endpoint: URL? {
        var urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
        var components: [URLQueryItem] = []
        
        if let likes = profileModel.likes {
            let likesString = likes.joined(separator: ",")
            components.append(URLQueryItem(name: "likes", value: likesString))
        }

        urlComponents?.queryItems = components
        return urlComponents?.url
    }
    var httpMethod: HttpMethod {
        return .put
    }
    
    var isUrlEncoded: Bool? {
        return true
    }
    
    var dto: Encodable?
}
