//
//  Models.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 29/08/2023.
//

import Foundation

public enum UserPostType: String {
    case photo = "photo"
    case video = "video"
}

enum Gender {
    case male, female
}

struct User {
    let username: String
    let bio: String
    let name: (firs: String, last: String)
    let profileImage: URL
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}


///Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postUrl: URL //either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [User]
    let owner: User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}
struct commentLike {
    let username: String
    let commentIdentifier: String
}
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [commentLike]
}
