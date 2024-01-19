//
//  JoueurSchema.swift
//  Pendix
//
//  Created by Faye on 2023-08-11.
//

import Foundation

// swiftlint: disable all
struct Joueur: Codable, Comparable {
    var rang: Int
    var nom: String
    var score: Double
    var jeuType: String

    static func < (lhs: Joueur, rhs: Joueur) -> Bool {
        return lhs.score > rhs.score
    }
}


