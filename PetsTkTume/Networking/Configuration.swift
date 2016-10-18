//
//  Configuration.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/13/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

struct Configuration {
    
    enum Environment: String {
        case production = "http://development.tektonlabs.com/pets-tk-app-prod/"
        case dev = "http://development.tektonlabs.com/pets-tk-app/"
        
        var baseURL: String { return rawValue}
    }
    
    let environment = Environment.dev
    
}
