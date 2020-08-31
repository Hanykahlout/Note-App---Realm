//
//  UserManager.swift
//  Notes
//
//  Created by Hany Kh on 23/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import RealmSwift
import SCLAlertView

class UserController {
    
    var realm = try! Realm()
    
    func create(user:User) {
        try! realm.write{
            realm.add(user)
        }
    }
    
    func read() -> Results<User> {
        let users = realm.objects(User.self)
        return users
    }
    
    func update(updatedUser:User) {
        try! realm.write{
            realm.add(updatedUser, update: .modified)
        }
    }
    func getUserById(userId:String) -> User? {
        let user = realm.objects(User.self).filter("id = '\(userId)'").first
        if let _user = user{
            return _user
        }
        return nil
    }
    
    
    
    
}
