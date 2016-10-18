//
//  SessionManager.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/14/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

class SessionManager {
    
    var user: User? = nil
    
    class func sharedInstance() -> SessionManager {
        struct Singleton {
            static var sharedInstance = SessionManager()
        }
        return Singleton.sharedInstance
    }
}
