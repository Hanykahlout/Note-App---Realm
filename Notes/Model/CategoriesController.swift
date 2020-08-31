//
//  CategoriesController.swift
//  Notes
//
//  Created by Hany Kh on 22/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import RealmSwift
import SCLAlertView
class CategoriesController {
    
    var realm = try! Realm()
    func save(category:Category,inUser:User) {
        try! realm.write{
            inUser.categries.append(category)
        }
    }
    func create(category:Category)  {
        try! realm.write{
            realm.add(category)
        }
    }
    func read() -> Results<Category> {
        let categories = realm.objects(Category.self)
        return categories
    }
    
    func update(updatedCategory:Category)  {
        try! realm.write{
            realm.add(updatedCategory, update: .modified)
        }
    }
    
    func delete(category:Category) {
        try! realm.write{
            realm.delete(category)
        }
    }
}
