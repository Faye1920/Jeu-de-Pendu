//
//  FilmSchema.swift
//  Pendix
//
//  Created by Faye on 2023-07-05.
//

import Foundation

// swiftlint: disable all
struct Film: Codable {
    let Title: String!
    let Released: String?
    let Ratings: [Rating]
    let Genre: String?
    let Director: String?
    let Actors: String?
}

struct Rating: Codable {
    let Source: String
    let Value: String
}
