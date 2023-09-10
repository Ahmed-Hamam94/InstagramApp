//
//  CameraViewController.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    // MARK: - Private Functions
    private func setUpUI(){
        title = "Camera"
        view.backgroundColor = .systemBackground
        tabBarItem.title = .none
       
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

   
   


}
