//
//  StorageManager.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 27/08/2023.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    //MARK: - public
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>)-> Void){
        
    }
    
    public func downloadImage(with refrence: String,completion: @escaping (Result<URL, StorageManagerError>)-> Void) {
        bucket.child(refrence).downloadURL(completion: { url, error in
            guard let url , error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        })
    }
}

public enum StorageManagerError: Error {
    case failedToDownload
    
}


