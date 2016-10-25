//
//  Pet.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/17/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

class Pet {
    
    let petId: Int
    var name: String
    var family: String
    var imageURL: String
    var profileURL: String
    var isFavorite: Bool?
    
    init(petId: Int, name: String, family: String, imageURL: String, profileURL: String, isFavorite: Bool) {
        self.petId = petId
        self.name = name
        self.family = family
        self.imageURL = imageURL
        self.profileURL = profileURL
        self.isFavorite = isFavorite
    }
    
}
