//
//  BookStoreSaleInfoCoreDataProperties.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import CoreData

extension SaleInfoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaleInfoData> {
        return NSFetchRequest<SaleInfoData>(entityName: "SaleInfoData")
    }

    @NSManaged public var saleability: String?
    @NSManaged public var buyLink: String?
}

extension SaleInfoData : Identifiable {

}
