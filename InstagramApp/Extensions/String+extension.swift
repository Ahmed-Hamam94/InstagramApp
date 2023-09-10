//
//  String+extension.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 26/08/2023.
//

import Foundation

extension String {
    
    func safeDataBaseKey()-> String{
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
