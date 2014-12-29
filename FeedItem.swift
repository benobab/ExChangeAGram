//
//  FeedItem.swift
//  ExChangAGram
//
//  Created by BenLacroix on 29/12/2014.
//  Copyright (c) 2014 Benobab. All rights reserved.
//

import Foundation
import CoreData
@objc(FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var image: NSData
    @NSManaged var thumbNail: NSData
    @NSManaged var caption: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var uniqueID: String
    @NSManaged var filtered: NSNumber

}
