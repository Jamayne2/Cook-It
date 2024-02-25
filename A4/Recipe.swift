//
//  Recipe.swift
//  Created by Jamayne Gyimah-Danquah on 11/11/23.
//

import Foundation

struct Recipe : Codable {
    let id: String
    let description : String
    let difficulty: String
    let imageUrl: String
    let name : String
    let rating: Double

}

