//
//  Constants.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 23/08/2023.
//

import Foundation

class Constants {
    
    
    enum AssetsColor: String {
        case AccentColor
        case BackgroundColor
        case PrimaryColor
        case SecondaryColor
        case BackgroundTextFieldColor
        case TextFieldPlaceholderColor
        case WarningColor
        case CellBackground
        case white
    }
    
    
    enum StoryBoard: String {
        
        case Home = "Home"
        case Explore = "Explore"
        case Camera = "Camera"
        case Notifications = "Notifications"
        case Profile = "Profile"
        
        var description : String {
            return self.rawValue
        }
        
    }
    
    
    enum Identifier : String{
        
        case Home = "HomeUIViewController"
        case Explore = "ExploreUIViewController"
        case Camera = "CameraUIViewController"
        case Notifications = "NotificationsUIViewController"
        case Profile = "ProfileUIViewController"
        
        var description : String {
            return self.rawValue
        }
        
    }
    
    
    
}
