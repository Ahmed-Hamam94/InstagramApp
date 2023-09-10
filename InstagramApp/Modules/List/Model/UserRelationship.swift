//
//  UserRelationship.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 30/08/2023.
//

import Foundation

enum FollowState {
    case following, not_following
}

struct UserRelationship{
    let name: String
    let username: String
    let type: FollowState
}
