//
//  User.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/17/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation


class User {
    
    let userID: Int
    var lastName: String
    var firstName: String
    var email: String
        
    init(userID: Int, lastName: String, firstName: String, email: String) {
        self.userID = userID
        self.lastName = lastName
        self.firstName = firstName
        self.email = email
    }
    
}
