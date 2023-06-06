//
//  DataManager.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookStore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    

    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteBook(book: BookStoreData) {
        let context = persistentContainer.viewContext
        context.delete(book)
        save()
    }
    
    func book(book: BookStore) -> BookStoreData {
        let imageLinks = ImageLinksData(context: persistentContainer.viewContext)
        imageLinks.smallThumbnail = book.volumeInfo.imageLinks?.smallThumbnail
        imageLinks.thumbnail = book.volumeInfo.imageLinks?.thumbnail
        
        let volumeInfo = VolumeInfoData(context: persistentContainer.viewContext)
        volumeInfo.title = book.volumeInfo.title
        volumeInfo.desc = book.volumeInfo.description
        volumeInfo.authors = book.volumeInfo.authors.joined(separator: ", ")
        volumeInfo.imageLinks = imageLinks
        
        let saleInfo = SaleInfoData(context: persistentContainer.viewContext)
        saleInfo.saleability = book.saleInfo.saleability.rawValue
        saleInfo.buyLink = book.saleInfo.buyLink
        
        let bookData = BookStoreData(context: persistentContainer.viewContext)
        bookData.id = book.id
        bookData.saleInfo = saleInfo
        bookData.volumeInfo = volumeInfo
        
        return bookData
    }
    
    func books() -> [BookStoreData] {
        let request: NSFetchRequest<BookStoreData> = BookStoreData.fetchRequest()
        var fetchedBooks: [BookStoreData] = []
            
        do {
            fetchedBooks = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching books \(error)")
        }
        return fetchedBooks
    }
    
    func getBookStores() -> [BookStore] {
        var books = books()
        var bookStores: [BookStore] = [BookStore]()
        
        for book in books {
            let saleability: Saleability = Saleability(rawValue: (book.saleInfo?.saleability)!) ?? .forSale
            let saleInfo = SaleInfo(saleability: saleability, buyLink: book.saleInfo?.buyLink)
            
            let imageLinks = ImageLinks(smallThumbnail: book.volumeInfo?.imageLinks?.smallThumbnail ?? "", thumbnail: book.volumeInfo?.imageLinks?.thumbnail ?? "")
            let volumeInfo = VolumeInfo(title: book.volumeInfo?.title ?? "", authors: book.volumeInfo?.authors?.components(separatedBy: ", ") ?? [], imageLinks: imageLinks, description: book.volumeInfo?.desc ?? "")
            
            let bookStore = BookStore(id: book.id ?? "", volumeInfo: volumeInfo, saleInfo: saleInfo)
            
            bookStores.append(bookStore)
        }
        
        return bookStores
    }
}
