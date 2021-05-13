//
//  Attraction.swift
//  HackChallenge_
//
//  Created by Varsha Iyer on 5/10/21.
//

import Foundation

struct Attraction: Codable{
    var id: Int
    var name: String
    var address: String
    var category: String
    var image: String
    var posts: [Post]
    
}

struct Post: Codable{
    var id: Int
    var name: String
    var picture: String
    var description: String
//    var comments: [Comment]
    
}

struct Comment: Codable{
    var id: Int
    var name: String
    var description: String
}
