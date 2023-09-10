//
//  PostRender.swift
//  InstagramApp
//
//  Created by Ahmed Hamam on 02/09/2023.
//

import Foundation
/// state of a render cell

enum PostRenderType{
    case header(provider: User)
    case primaryContent(provider: UserPost) // post
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComment])
}
/// model of renderd post
struct PostRenderModel {
    let renderType: PostRenderType
}
