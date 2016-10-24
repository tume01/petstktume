//
//  PetService.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/20/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

class PetService {
    
    func getPets(userId: Int, completionHandler: @escaping (_ result: NetworkResult<Any>) -> Void) {
        var pets: [Pet] = []
        
        let request = RequestBuilder().makeRequest(with: ["user_id": userId], path: "pets.json", token: (SessionManager.sharedInstance().user?.token)!, method: HTTPMethods.get)
        
        let task = NetworkManager.sharedInstance().dataTask(with: request) {
            networkResult in
            
            switch networkResult {
            case .success(let result):
                for(value) in (result as! [[String: Any]]) {
                    if let pet = Pet(json: value) {
                        pets.append(pet)
                    }
                }
                completionHandler(NetworkResult.success(result: pets))
            case .error(let error):
                print(error)
                completionHandler(networkResult)
            }
        }
        
        task.resume()
    }
    
    func getFavoritePets(userId: Int, completionHandler: @escaping(_ result: NetworkResult<Any>) -> Void) {
        var pets: [Pet] = []
        
        let request = RequestBuilder().makeRequest(with: [:], path: "users/" + userId.description + "/favorite_pets.json", token: "", method: HTTPMethods.get)
        
        let task = NetworkManager.sharedInstance().dataTask(with: request) {
            networkResult in
            
            switch networkResult {
            case .success(let result):
                for(value) in (result as! [[String: Any]]) {
                    if let pet = Pet(json: value) {
                        pets.append(pet)
                    }
                }
                completionHandler(NetworkResult.success(result: pets))
            case .error(let error):
                print(error)
                completionHandler(networkResult)
            }
        }
        
        task.resume()
    }
    
    class func sharedInstance() -> PetService {
        struct Singleton {
            static var sharedInstance = PetService()
        }
        return Singleton.sharedInstance
    }
    
}

extension Pet {
    convenience init?(json: [String: Any]) {
        guard let petId = json["id"] as? Int,
            let name = json["name"] as? String,
            let family = json["family"] as? String,
            let profileURL = json["url"] as? String,
            let isFavorite = json["is_favorite"] as? Bool else {
                print(json["image_url"])
                return nil
        }
        let imageURL = json["image_url"] as? String
        
        self.init(petId: petId, name: name, family: family, imageURL: imageURL!, profileURL: profileURL, isFavorite: isFavorite)
    }
}
