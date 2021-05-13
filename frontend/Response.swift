//
//  Response.swift
//  HackChallenge_
//
//  Created by Varsha Iyer on 5/10/21.
//

import Foundation

struct Response<T: Codable>: Codable {

    var data: T
    var success: Bool

}
