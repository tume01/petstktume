//
//  SessionService.swift
//  PetsTkTume
//
//  Created by Franco Tume on 10/14/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import Foundation

class SessionService {
    
    func login(credentials: [String:String], completionHandler: @escaping (_ result: NetworkResult<Any>) -> Void ) {
        let request = RequestBuilder().makeRequest(with: credentials, path: "users/sign_in.json", token: "", method: HTTPMethods.post)
        
        let task = NetworkManager.sharedInstance().dataTask(with: request) {
            networkResult in
            
            switch networkResult {
            case .success(let result):
                SessionManager.sharedInstance().user = User(json: result as! [String : Any])
            case .error(let error):
                print(error)
                SessionManager.sharedInstance().user = nil
            }
            
            completionHandler(networkResult)
           
        }
        
        task.resume()
        
        
    }
    
    class func sharedInstance() -> SessionService {
        struct Singleton {
            static var sharedInstance = SessionService()
        }
        return Singleton.sharedInstance
    }
}

extension User {
    
    convenience init?(json: [String: Any]) {
        
        guard let userID = json["id"] as? Int,
            let lastName = json["last_name"] as? String,
            let firstName = json["first_name"] as? String,
            let email = json["email"] as? String else {
                
                return nil
                
        }
        
        self.init(userID: userID, lastName: lastName, firstName: firstName, email: email)
        
        
    }
    
}
