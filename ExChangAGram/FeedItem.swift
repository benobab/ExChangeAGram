//
//  FeedItem.swift
//  ExChangAGram
//
//  Created by BenLacroix on 16/12/2014.
//  Copyright (c) 2014 Benobab. All rights reserved.
//

import Foundation
import CoreData

@objc(FeedItem)
class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData

}
