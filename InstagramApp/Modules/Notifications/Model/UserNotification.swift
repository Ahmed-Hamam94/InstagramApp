//
//  UserNotification.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 31/08/2023.
//

import Foundation

struct UserNottification {
    
    let type: UserNottificationType
    let text: String
    let user: User
}

enum UserNottificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}
