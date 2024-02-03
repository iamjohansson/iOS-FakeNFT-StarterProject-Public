//
//  OrderGetRequest.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 03.02.24.
//

import Foundation

struct OrderGetRequest: NetworkRequest {
    var endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
}
