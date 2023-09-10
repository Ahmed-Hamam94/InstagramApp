//
//  TabBarVC.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit

class TabBarVC: UITabBarController {
    // MARK :Variables
    
    lazy var home : UINavigationController = {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
      
        vc.tabBarItem.image = UIImage(systemName: "house")
        return UINavigationController(rootViewController: vc)
    }()
    
    lazy var explore : UINavigationController = {
        let vc = UIStoryboard(name: "Explore", bundle: nil).instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
      
        vc.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        return UINavigationController(rootViewController: vc)
        
    }()
    lazy var camera : UINavigationController = {
        let vc = UIStoryboard(name: "Camera", bundle: nil).instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
      
        vc.tabBarItem.image = UIImage(systemName: "plus")
        return UINavigationController(rootViewController: vc)
        
    }()
    
    lazy var notifications : UINavigationController = {
        let vc = UIStoryboard(name: "Notifications", bundle: nil).instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
        
        vc.tabBarItem.image = UIImage(systemName: "heart")
        return UINavigationController(rootViewController: vc)
        
    }()
    
    lazy var profile : UINavigationController = {
        let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
      
        vc.tabBarItem.image = UIImage(systemName: "person")
        return UINavigationController(rootViewController: vc)
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
setViewControllers([home, explore, camera, notifications, profile] , animated: true)
        // Hide tab bar item titles
            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -20)
       
       
    }
    

    

}
