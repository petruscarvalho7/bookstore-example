//
//  BookStoreDirectoryAPI.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation
import Alamofire

typealias BookStoreListAPIResponse = (Swift.Result<[BookStore]?, DataError>) -> Void

/// API interface to retrieve schools
protocol BookStoreAPILogic {
    func getBooks(page: String, completion: @escaping (BookStoreListAPIResponse))
}

class BookStoreAPI: BookStoreAPILogic {
    /// NYC School API URL returning list of schools with details
    private struct Constants {
        static let baseURL = BuildConfiguration.shared.baseURL
        static let booksListURL = "volumes?q=ios&maxResults=20&startIndex="
    }
    
    func getBooks(page: String, completion: @escaping (BookStoreListAPIResponse)) {
        URLCache.shared.removeAllCachedResponses()

        AF.request(Constants.baseURL + Constants.booksListURL + page)
            .validate()
            .responseDecodable(of: BookStoreList.self) { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    completion(.failure(.networkingError(error.localizedDescription)))
                case .success(let bookList):
                    completion(.success(bookList.items))
                }
            }
    }
}
