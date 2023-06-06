//
//  SaleInfo.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation

enum Saleability: String, Decodable {
    case forSale = "FOR_SALE"
    case notForSale = "NOT_FOR_SALE"
}

struct SaleInfo: Decodable {
    let saleability: Saleability
    let buyLink: String?
    
    enum CodingKeys: String, CodingKey {
        case saleability
        case buyLink
    }
}
