//
//  BookStoreImageLinksCoreDataProperties.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import CoreData

extension ImageLinksData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageLinksData> {
        return NSFetchRequest<ImageLinksData>(entityName: "ImageLinksData")
    }

    @NSManaged public var smallThumbnail: String?
    @NSManaged public var thumbnail: String?
}

extension ImageLinksData : Identifiable {

}
