//
//  JeuPendu.swift
//  Pendix
//
//  Created by Faye on 2023-07-05.
//

import Foundation
import UIKit

struct EndOfGameInformation {
    let win: Bool
    let title: String
    let cntErrors: Int
    var finalMessage: String {
        return """
            win: \(win) in \(cntErrors)/7.
            Title was :
            \(title)
            """
    }
}

class JeuPendu {
    
    static let shared: JeuPendu = JeuPendu()
    
    private init() {}
    
    //
    private let maxErreur: Int = 7
    private var nbErreurs: Int = 0
    private var titreADeviner: [Character] = []
    private var indexTrouves: [Bool] = []
    private var lettresUtilisateurs: [Character] = []
    private var filmADeviner: Film?
    
    
    
    
    var devinette: String {
        let arr = indexTrouves.indices.map {indexTrouves[$0] ? titreADeviner[$0] : "#"}
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
    
    func jouer(avec film: Film) {
        filmADeviner = film
        titreADeviner = Array(film.Title)
        indexTrouves = Array(repeating: false, count: titreADeviner.count)
        //Display non alphabetic character
        titreADeviner.enumerated().forEach { (idx, lettre) in
            if !CharacterSet.alphanumerics.contains(UnicodeScalar(String(lettre))!) {
                indexTrouves[idx] = true
            }
        }
        print("DB: jouer() ", devinette)
        
        nbErreurs = 0
        
        lettresUtilisateurs = []
    }
    
    func verifier(lettre: Character) {
        lettresUtilisateurs.append(lettre)
        var trouvee = false
        
        titreADeviner.enumerated().forEach { (idx, lettreMystere) in
            if lettreMystere.lowercased() == lettre.lowercased() {
                indexTrouves[idx] = true
                trouvee = true
            }
        }
        
        if !trouvee {
            nbErreurs += 1
            
            var directorsString = "N/A"
            var actorsString = "N/A"
            
            if nbErreurs == 2 {
                // Display the movie's release year as a hint
                let releaseYear = filmADeviner?.Released ?? "N/A"
                displayHintAlert(title: "Plus d'information", message: "Released: \n\(releaseYear)")
                print("Released: \(releaseYear)")
            } else if nbErreurs == 4 {
                // Display the movie's rating and genre as hints
                let rating = filmADeviner?.Ratings[0].Value ?? "N/A"
                let genre = filmADeviner?.Genre ?? "N/A"
                displayHintAlert(title: "Plus d'information", message: "Rating: \n\(rating)\nGenre: \n\(genre)")
                print("Rating: \(rating) \nGenre: \(genre)")
            } else if nbErreurs == 5 {
                let directorsString = filmADeviner?.Director ?? "N/A"
                let directorsArray = directorsString.components(separatedBy: ", ")
                let deuxDirectors = Array(directorsArray.prefix(2))
                let formattedDirectors = deuxDirectors.joined(separator: ", ")
                
                let actorsString = filmADeviner?.Actors ?? "N/A"
                let actorsArray = actorsString.components(separatedBy: ", ")
                let troisActors = Array(actorsArray.prefix(3))
                let formattedActors = troisActors.joined(separator: ", ")
                
                displayHintAlert(title: "Plus d'information", message: "Réalisateur: \n\(formattedDirectors) \nActeurs: \n\(formattedActors)")
                
            }
        }
    }
    
    func getCurrentNbErrors() -> Int {
        return nbErreurs
    }
    
    
    func displayHintAlert(title: String, message: String) {
        let hintAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        hintAlert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        // Assuming that your ViewController is the presenting view controller
        UIApplication.shared.windows.first?.rootViewController?.present(hintAlert, animated: true, completion: nil)
    }
    
    
    func verifierFinDePartie() -> String? {
        if nbErreurs == maxErreur {
            
            return EndOfGameInformation(win: false, title: String(titreADeviner), cntErrors: nbErreurs).finalMessage
        } else if indexTrouves.allSatisfy({$0}) {
            
            return EndOfGameInformation(win: true, title: String(titreADeviner), cntErrors: nbErreurs).finalMessage
        }
        return nil
    }
    
    
}
