//
//  CDDebt+CoreDataProperties.swift
//  dabit
//
//  Created by gebeto on 28.08.2021.
//
//

import Foundation
import CoreData


extension CDDebt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDDebt> {
        return NSFetchRequest<CDDebt>(entityName: "CDDebt")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var avatar: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension CDDebt : Identifiable {

}
