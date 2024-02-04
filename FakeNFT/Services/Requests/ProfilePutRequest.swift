//
//  ProfilePutRequest.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 21.01.2024.
//

import Foundation

struct ProfilePutRequest: NetworkRequest {
    
    let profileModel: ProfileModelEditing
    init(profileModel: ProfileModelEditing) {
           self.profileModel = profileModel
       }

    var endpoint: URL? {
        guard
            var urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
        else { return nil }
        
        var queryItems: [URLQueryItem] = []
        if let name = profileModel.name {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if let description = profileModel.description {
            queryItems.append(URLQueryItem(name: "description", value: description))
        }
        if let website = profileModel.website {
            queryItems.append(URLQueryItem(name: "website", value: website))
        }
        if let likes = profileModel.likes {
            for likedId in likes {
                queryItems.append(URLQueryItem(name: "likes", value: likedId))
            }
        }
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        return urlComponents.url
    }
    var httpMethod: HttpMethod {
        return .put
    }
    
}


