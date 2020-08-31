//
//  User.swift
//  Notes
//
//  Created by Hany Kh on 30/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import RealmSwift
class User: Object{
    
    @objc dynamic var id = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var email = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var password = ""
    let categries = List<Category>()
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
