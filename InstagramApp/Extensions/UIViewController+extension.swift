//
//  UIViewController+extension.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 25/08/2023.
//

import UIKit

extension UIViewController {
    
    func alert(title: String? = nil , message: String? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
    func logOutAlert(completion: @escaping ()->()){
        let action = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        action.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        action.addAction(UIAlertAction(title: "Log Out", style: .destructive,handler: {
            _ in
            completion()
        }))
        present(action, animated: true)
    }
    
    func actionSheet(title: String? = nil , message: String? = nil, actionTitle: String? = nil ,completion: @escaping ()->()){
        
        let actionSheet = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: actionTitle, style: .destructive,handler: { _ in
            completion()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
}
