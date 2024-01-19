//
//  ScoreViewController.swift
//  Pendix
//
//  Created by Faye on 2023-08-11.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var filmLabel: UILabel!
    @IBOutlet weak var motLabel: UILabel!
    
    
    var numberOfAttempts: Int = 0
    var isWin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScoreStore.getScores { [weak self] scores in
            // Filter out scores with zero
            let filteredScores = scores.filter { $0.score > 0 }

            // Sort the scores in descending order
            let sortedScores = filteredScores.sorted { $0.score > $1.score }

            // Get the top 5 scores for Film and Mot
            let topFilmScores = sortedScores.filter { $0.gameType == "Film" }.prefix(5)
            let topMotScores = sortedScores.filter { $0.gameType == "Mot" }.prefix(5)

            var filmText = ""
            for score in topFilmScores {
                if let name = score.username {
                    filmText += name + "\t\t"
                }
                filmText += String(score.score) + "\n"
            }

            var motText = ""
            for score in topMotScores {
                if let name = score.username {
                    motText += name + "\t\t"
                }
                motText += String(score.score) + "\n"
                    }

                self?.filmLabel.text = filmText
                self?.motLabel.text = motText
            }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
