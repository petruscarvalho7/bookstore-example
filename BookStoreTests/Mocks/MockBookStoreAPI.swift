//
//  MockBookStoreAPI.swift
//  BookStoreTests
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
@testable import BookStore_debug

class MockBookStoreAPI: BookStoreAPILogic {
    var loadState: BookStoreListLoadState = .empty
    
    func getBooks(page: String, completion: @escaping (BookStore_debug.BookStoreListAPIResponse)) {
        switch loadState {
        case .error:
            completion(.failure(.networkingError("Couldn't fetch data")))
        case .empty:
            completion(.success([]))
        case .loaded:
            let imageLinks = ImageLinks(smallThumbnail: "small-thumbnail", thumbnail: "thumbnail")
            let volumeInfo = VolumeInfo(title: "title", authors: ["Author Test"], imageLinks: imageLinks, description: "description test")
            let saleInfo = SaleInfo(saleability: .forSale, buyLink: "https://developer.apple.com/documentation/xctest/xctfail")
            let dataMock: BookStore = BookStore(id: "1", volumeInfo: volumeInfo, saleInfo: saleInfo)
            completion(.success([dataMock]))
        }
    }
}
