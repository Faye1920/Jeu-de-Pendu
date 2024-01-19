//
//  JeuMot.swift
//  Pendix
//
//  Created by Faye on 2023-08-11.
//

import Foundation
import UIKit

struct EndOfGameMot {
    let win: Bool
    let word: String
    let cntErrors: Int
    var finalMessage: String {
        return """
            win: \(win) in \(cntErrors)/6.
            Word was :
            \(word)
            """
    }
}

class JeuMot {
    
    static let shared: JeuMot = JeuMot()
    
    private init() {}
    
    //
    private let maxErreur: Int = 6
    private var nbErreurs: Int = 0
    private var motADeviner: [Character] = []
    private var indexTrouves: [Bool] = []
    private var lettresUtilisateurs: [Character] = []
    private var wordADeviner: RandomWord?
    
    var devinette: String {
        let arr = indexTrouves.indices.map {indexTrouves[$0] ? motADeviner[$0] : "#"}
        return String(arr)
    }
    var lettreUtilisees: String {
        return Array(lettresUtilisateurs).map {String($0)}.joined(separator: ", ")
    }
    var erreurs: String {
        return "\(nbErreurs) / \(maxErreur)"
    }
    var image : UIImage {
        return UIImage(named: imageNamesSequence[nbErreurs])!
    }
    
    func jouer(avec word: String) {
        let wordString = word
        motADeviner = Array(wordString)
        indexTrouves = Array(repeating: false, count: motADeviner.count)
        // Display non-alphabetic characters
        motADeviner.enumerated().forEach { (idx, lettre) in
            if !("abcdefghijklmnopqrstuvwxyz".contains(lettre.lowercased())) {
                indexTrouves[idx] = true
            }
        }
        print("DB: jouer() ", "Pendix.Word(\(wordString))")

        nbErreurs = 0
        lettresUtilisateurs = []
    }

    
    func verifier(lettre: Character) {
        lettresUtilisateurs.append(lettre)
        var trouvee = false
        
        motADeviner.enumerated().forEach { (idx, lettreMystere) in
            if lettreMystere.lowercased() == lettre.lowercased() {
                indexTrouves[idx] = true
                trouvee = true
            }
        }
        
        if !trouvee {
            nbErreurs += 1
        }
    }
    
    func getCurrentNbErrors() -> Int {
        return nbErreurs
    }
    
    func verifierFinDePartie() -> String? {
        if nbErreurs == maxErreur {
            return EndOfGameMot(win: false, word: String(motADeviner), cntErrors: nbErreurs).finalMessage
        } else if indexTrouves.allSatisfy({$0}) {
            return EndOfGameMot(win: true, word: String(motADeviner), cntErrors: nbErreurs).finalMessage
        }
        return nil
    }
}
