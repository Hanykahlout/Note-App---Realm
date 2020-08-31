//
//  Note.swift
//  Notes
//
//  Created by Hany Kh on 30/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import RealmSwift
class Note:Object{
    
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var descriptions = ""
    @objc dynamic var stauts = false
    let category = LinkingObjects(fromType: Category.self, property: "notes")
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
