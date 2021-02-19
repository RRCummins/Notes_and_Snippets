//
//  Models.swift
//  InstaScroll
//
//  Created by Ryan Cummins on 2/19/21.
//

import Foundation

enum Gender {
    case male, female, other
}

public struct User {
    let userName: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinedDate: Date
}

struct UserCount{
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType {
    case photo, video
}

/// Represents a user post
public struct UserPost {
    let identifier: String
    let PostType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}
struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}