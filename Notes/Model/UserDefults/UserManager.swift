//
//  UserManager.swift
//  Notes
//
//  Created by Hany Kh on 23/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation

class UserManager {
    
    let userController:UserController!
    
    init() {
        userController = UserController()
    }
    func create(user:User)  {
        UserDefaults.standard.set(user.id, forKey: "User")
    }
    
    func read() -> User {
        let userId = UserDefaults.standard.string(forKey: "User")
        let user = userController.getUserById(userId: userId!)
        return user!
    }
    
}
