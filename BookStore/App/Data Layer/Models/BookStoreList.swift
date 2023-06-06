//
//  BookStoreList.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation

struct BookStoreList: Decodable {
    let items: [BookStore]

    enum CodingKeys: String, CodingKey {
        case items
    }
}
