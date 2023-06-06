//
//  VolumeInfo.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation

struct VolumeInfo: Decodable {
    let title: String
    let authors: [String]
    let imageLinks: ImageLinks?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case description
        case imageLinks
    }
}
