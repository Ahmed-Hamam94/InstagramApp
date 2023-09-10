//
//  AuthManager.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 24/08/2023.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(userName: String, email: String, password: String,completion: @escaping ((Bool) -> Void)){
        /*
         - check if userName is available
         - check if email is available
         */
        DataBaseManager.shared.canCreateNewUser(with: email, userName: userName) { (canCreate) in
            if canCreate {
               // - create acc
               // - insert acc to database
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard authResult != nil , error == nil else {
                        //firebase auth could not create acc
                    completion(false)
                        return
                    }
                    // - insert acc to database
                    DataBaseManager.shared.inserNewUser(with: email, userName: userName) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }else {
                            // failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }else{
                //either userName or email does not exit
                completion(false)
            }
        }
    }
    
    public func login(userName: String?, email: String?, password: String,  completion: @escaping ((Bool) -> Void)){
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil , error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
            
        }else if let userName = userName {
            // username log in
            print(userName)
        }
    }
    
    public func logOut(completion: @escaping (Bool)-> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            print(error)
            completion(false)
            return
        }
        
    }
    
}
