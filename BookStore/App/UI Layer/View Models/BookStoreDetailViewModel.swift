//
//  BookStoreDetailViewModel.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation

class BookStoreDetailViewModel {
    private(set) var book: BookStore?
    private(set) var sectionList: [BookStoreDetailTypeSection]?
    private(set) var isFavorite: Bool = false
    
    func populate(book: BookStore, isFavorite: Bool = false) {
        self.book = book
        self.isFavorite = isFavorite
        prepareSectionList()
    }
    
    func handleFavoriteBtn() {
        self.isFavorite = !self.isFavorite
    }
    
    private func prepareSectionList() {
        sectionList = [BookStoreDetailTypeSection]()
        
        sectionList?.append(.information)
        sectionList?.append(.buttons)
    }
}
