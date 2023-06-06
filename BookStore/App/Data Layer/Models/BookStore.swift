//
//  BookStore.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation

struct BookStore: Decodable {
    let id: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
    
    enum CodingKeys: String, CodingKey {
        case id
        case volumeInfo
        case saleInfo
    }
}
