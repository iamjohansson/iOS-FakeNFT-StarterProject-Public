//
//  ProfileGetRequest.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 25.01.24.
//

import Foundation

struct ProfileGetRequest: NetworkRequest {
    var endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
}
