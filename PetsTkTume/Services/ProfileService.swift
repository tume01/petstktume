//
//  ProfileService.swift
//  PetsTkTume
//
//  Created by Franco Tume on 11/2/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

class ProfileService {
    
    func editProfile(userId: Int, newName: String, newLastName: String, newEmail: String, completionHandler: @escaping (_ result: NetworkResult<Any>) -> Void) {
        
        let newUserInfo = [
            "user" : [
                "email": newEmail,
                "first_name": newName,
                "last_name": newLastName
            ]
        ]
        
        let request = RequestBuilder().makeRequest(with: newUserInfo, path: "users/\(userId).json", token: "", method: HTTPMethods.put)
        
        let task = NetworkManager.sharedInstance().dataTask(with: request) {
            networkResult in
            
            switch networkResult {
            case .success(let result):
                if let user = User(json: result as! [String: Any]) {
                    completionHandler(NetworkResult.success(result: user))
                }
                completionHandler(networkResult)
            case .error:
                completionHandler(networkResult)
            }
            
        }
        
        task.resume()
        
    }
    
    class func sharedInstance() -> ProfileService {
        struct Singleton {
            static var sharedInstance = ProfileService()
        }
        return Singleton.sharedInstance
    }
}
