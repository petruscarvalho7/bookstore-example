//
//  ImageLinks.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation

struct ImageLinks: Decodable {
    let smallThumbnail: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case smallThumbnail
        case thumbnail
    }
}
