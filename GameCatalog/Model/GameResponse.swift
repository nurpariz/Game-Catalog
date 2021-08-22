//
//  GameResponse.swift
//  GameCatalog
//
//  Created by Nurpariz Muhammad on 10/08/21.
//

import Foundation

struct GameResponse: Codable {
    let results: [Game]
    let totalData: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalData = "count"
    }
}

struct Game: Codable {
    let id: Int
    let name: String
    let released: String?
    let image: String?
    let rating: Float
    let genres: [Genres]
    let platforms: [Platforms]?
    let ratings: [Ratings]
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, genres, platforms, ratings, description
        case image = "background_image"
    }
}

struct Genres: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Platforms: Codable {
    let platform: DetailPlatform
}

struct DetailPlatform: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Ratings: Codable {
    let title: String
    let percent: Float
    
    enum CodingKeys: String, CodingKey {
        case title, percent
    }
}
