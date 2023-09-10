//
//  StorageManager.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 24/08/2023.
//


import FirebaseDatabase


      

public class DataBaseManager {
    
    static let shared = DataBaseManager()


    var ref = Database.database().reference()
    
    // MARK: - public func
    
    /// check if userName and email are available
    public func canCreateNewUser(with email: String, userName: String, completion: (Bool)-> Void){
        completion(true)
    }
    
    ///  insert new user data to database
    ///  - parameters
    ///  - email: string representing email
    ///   - userName: string representing userName
    ///    - completion: Async callback for result if database succeded
    public func inserNewUser(with email: String, userName: String, completion: @escaping (Bool)-> Void ){
       let key = email.safeDataBaseKey()
//        print(key)
        
        ref.child(key).setValue(["username": userName]){
            error , _ in
            //succed
            if error == nil {
                completion(true)
                return
            }else {
                //failed
                completion(false)
                return
            }
        }
    }
    // MARK: - private func
  
}
