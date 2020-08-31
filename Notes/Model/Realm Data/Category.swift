//
//  Category.swift
//  Notes
//
//  Created by Hany Kh on 30/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import RealmSwift
class Category:Object{
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var descriptions = ""
    let user = LinkingObjects(fromType: User.self, property: "categries")
    let notes = List<Note>()
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
