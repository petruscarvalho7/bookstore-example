//
//  BookStoreViewModel.swift
//  BookStore
//
//  Created by Petrus Carvalho on 05/06/23.
//

import Foundation
import Combine

class BookStoreViewModel {
    @Published private(set) var books: [BookStore] = []
    @Published private(set) var error: DataError? = nil
    @Published private(set) var savedBooks: [BookStore] = []
    private(set) var pagination: String = "0"
    
    @Service private var apiService: BookStoreAPILogic
    
    init(apiService: BookStoreAPILogic = BookStoreAPI()) {
        self.apiService = apiService
    }
    
    func getBooks(page: String? = nil) {
        apiService.getBooks(page: page ?? self.pagination) { [weak self] result in
            switch result {
            case .success(let books):
                if page == "0" || self?.pagination == "0" {
                    self?.books = books ?? []
                } else {
                    self?.books = (self?.books ?? []) + (books ?? [])
                }
                
                if let pageNumber = NumberFormatter().number(from: self?.pagination ?? "0") {
                    self?.pagination = String(pageNumber.intValue + 1)
                }
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    func setSavedBooks(books: [BookStore]) {
        self.savedBooks = books
    }
    
    func addSavedBook(book: BookStore) {
        savedBooks.append(book)
    }
    
    func removeSavedBook(book: BookStore) {
        if let index = savedBooks.firstIndex(where: { $0.id == book.id }) {
            savedBooks.remove(at: index)
        }
    }
}
