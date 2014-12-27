//
//  FeedItem.swift
//  ExChangAGram
//
//  Created by BenLacroix on 27/12/2014.
//  Copyright (c) 2014 Benobab. All rights reserved.
//

import Foundation
import CoreData

@objc(FeedItem) //ne pas oublier
class FeedItem: NSManagedObject {

    @NSManaged var image: NSData
    @NSManaged var thumbNail: NSData

}
