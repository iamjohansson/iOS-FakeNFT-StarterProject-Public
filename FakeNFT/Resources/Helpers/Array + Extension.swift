//
//  Array + Extension.swift
//  FakeNFT
//
//  Created by Ivan Zhoglov on 29.01.2024.
//

import Foundation

extension Array {
    mutating func sort<T: Comparable>(by keyPath: KeyPath<Element, T>) {
        sort { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

