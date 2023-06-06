//
//  BookStoreSaleInfoCoreDataClass.swift
//  BookStore
//
//  Created by Petrus Carvalho on 06/06/23.
//

import Foundation
import CoreData

extension VolumeInfoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VolumeInfoData> {
        return NSFetchRequest<VolumeInfoData>(entityName: "VolumeInfoData")
    }

    @NSManaged public var title: String?
    @NSManaged public var authors: String?
    @NSManaged public var imageLinks: ImageLinksData?
    @NSManaged public var desc: String?
}

extension VolumeInfoData : Identifiable {

}
