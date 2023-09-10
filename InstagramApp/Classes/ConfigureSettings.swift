//
//  ConfigureSettings.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 27/08/2023.
//

import UIKit
import SafariServices

class ConfigureSettings {
    
    static let shared = ConfigureSettings()
    
    
    func didTapEditProfile(_ viewController: UIViewController){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        viewController.present(navVC, animated: true)
    }
    
    func didTapInviteFriends(){
        
    }
    
    func didTapSaveOriginalPosts(){
        
    }
    
    func openURL(type: SettingsURLType, _ viewController: UIViewController){
        let urlString: String
        switch type {
        case .terms : urlString = "https://help.instagram.com/581066165581870"
        case .privacy : urlString = "https://help.instagram.com/155833707900388"
        case .help : urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        viewController.present(vc, animated: true)
    }
    

    
    
    func logOut(_ Vc: UIViewController){
        AuthManager.shared.logOut {  success in
            DispatchQueue.main.async {
                if success {
                    //present log in
                    let loginVc = LoginViewController()
                    loginVc.modalPresentationStyle = .fullScreen
                    //compeltion in present to :when user log in back again open in home instead of settings
                    
                    Vc.present(loginVc, animated: true){
                        Vc.navigationController?.popToRootViewController(animated: false)
                        Vc.tabBarController?.selectedIndex = 0
                    }
                }else{
                    //error
                }
            }
            
        }
    }
    
    public enum SettingsURLType {
        case terms, privacy, help
    }
}
