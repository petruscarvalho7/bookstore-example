//
//  BookStoreCoreDataProperties.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import CoreData

extension BookStoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookStoreData> {
        return NSFetchRequest<BookStoreData>(entityName: "BookStoreData")
    }

    @NSManaged public var id: String?
    @NSManaged public var volumeInfo: VolumeInfoData?
    @NSManaged public var saleInfo: SaleInfoData?
}

// MARK: Generated accessors for songs
extension BookStoreData {

}

extension BookStoreData : Identifiable {

}
