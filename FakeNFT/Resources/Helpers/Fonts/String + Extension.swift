//
//  String + Extension.swift
//  FakeNFT
//
//  Created by Almira Khafizova on 18.01.24.
//

import Foundation

extension String {
    var urlEncoder: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }

    var urlDecoder: String {
        return self.removingPercentEncoding!
    }
}
