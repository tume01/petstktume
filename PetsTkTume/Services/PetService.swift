//
//  PetService.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/20/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation
import Alamofire

enum PetError: Error {
    case parseError
}

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
    
    func createPet(userId: Int, petName: String, petFamilyName: String, petImage: Data, completionHandler: @escaping(_ result: NetworkResult<Any>) -> Void) {
        
        let parameters = [
                "name": petName,
                "family": petFamilyName,
                "user_id": userId.description
        ] as [String : Any]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append((parameters["name"] as! String).data(using: .utf8, allowLossyConversion: false)!, withName: "pet[name]")
                multipartFormData.append((parameters["family"] as! String).data(using: .utf8, allowLossyConversion: false)!, withName: "pet[family]")
                multipartFormData.append((parameters["user_id"] as! String).data(using: .utf8, allowLossyConversion: false)!, withName: "pet[user_id]")
                multipartFormData.append(petImage, withName: "pet[image]", fileName: "test.jpg", mimeType: "image/jpeg")

            },
            to: "http://development.tektonlabs.com/pets-tk-app/pets.json",
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.responseJSON { response in
                        guard let pet = Pet(json: (response.result.value as? [String : Any])!) else{
                            return completionHandler(NetworkResult.error(error: PetError.parseError))
                        }
                        completionHandler(NetworkResult.success(result: pet))
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )

    }
    
    func setFavoritePet(userId: Int, petId: Int, isFavorite: Bool, completionHandler: @escaping(_ result: NetworkResult<Any>) -> Void) {
        
        let path: String
        let method: HTTPMethods
        
        if (isFavorite) {
            path = "pets/\(petId)/add_favorite.json"
            method = HTTPMethods.post
            
        }else {
            path = "pets/\(petId)/remove_favorite.json"
            method = HTTPMethods.delete
        }
        
        let request = RequestBuilder().makeRequest(with: ["user_id": userId], path: path, token: (SessionManager.sharedInstance().user?.token)!, method: method)
        
        let task = NetworkManager.sharedInstance().dataTask(with: request) {
            networkResult in
            
            switch networkResult {
            case .success(let result):
                guard let pet = Pet(json: (result as? [String : Any])!) else{
                    return completionHandler(NetworkResult.error(error: PetError.parseError))
                }
                
                completionHandler(NetworkResult.success(result: pet))
            case .error:
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
            let family = json["family"] as? String else {
                print(json["image_url"])
                return nil
        }
        
        let isFavorite = json["is_favorite"] as? Bool
        let profileURL = json["url"] as? String
        let imageURL = json["image_url"] as? String
        
        self.init(petId: petId, name: name, family: family, imageURL: imageURL!, profileURL: profileURL ?? "", isFavorite: isFavorite ?? false)
    }
}
