//
//  ReussiViewController.swift
//  Pendix
//
//  Created by Faye on 2023-08-11.
//

import UIKit

class ReussiViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var numberOfAttempts: Int = 0
    var isWin: Bool = false
    var cntErrors: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        // Use currentNbErrors as the value of numberOfAttempts
        let jeuMot = JeuMot.shared
        numberOfAttempts = jeuMot.getCurrentNbErrors()
        
        if numberOfAttempts < 6 {
            let remainingAttempts = 6 - numberOfAttempts
            let score = remainingAttempts * 100 / 6
            resultLabel.text = "Félicitations ! Vous avez perdu \(numberOfAttempts) essai\(numberOfAttempts > 1 ? "s" : "")."
            scoreLabel.text = "Score : \(score)"
            
            // Save score to UserDefaults
            UserDefaults.standard.set(score, forKey: "gameScore")
            
            // Save the score
            if let username = UserDefaults.standard.string(forKey: "username") {
                ScoreStore.saveScore(username: username, gameType: "Mot", score: score)
            }
            
            print("Mot Score: \(score)")
        } else {
            resultLabel.text = "Échec ! Vous avez utilisé \(numberOfAttempts) essai\(numberOfAttempts > 1 ? "s" : "")."
            let score = 0
            scoreLabel.text = "Score : \(score)"
            
            // Save score to UserDefaults
            UserDefaults.standard.set(score, forKey: "gameScore")
            
            // Save the score
            if let username = UserDefaults.standard.string(forKey: "username") {
                ScoreStore.saveScore(username: username, gameType: "Mot", score: score)
            }
            
            print("Mot Score: \(score)")
        }
        
        // Add a return button to navigate back to FilmViewController
        let returnButton = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(returnButtonTapped))
        navigationItem.leftBarButtonItem = returnButton
    }
    
    @objc func returnButtonTapped() {
        // Show an alert to confirm if the user wants to start a new game
        let alert = UIAlertController(title: "Fin", message: "Voulez-vous commencer un nouveau？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oui", style: .default) { _ in
            self.startNewGame()
        })
        alert.addAction(UIAlertAction(title: "Non", style: .cancel) { _ in
            self.navigateToScoreViewController(isWin: self.isWin, numberOfAttempts: self.numberOfAttempts)
        })
        present(alert, animated: true, completion: nil)
    }
    
    func startNewGame() {
        // Code to reset game data and return to FilmViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let motViewController = storyboard.instantiateViewController(withIdentifier: "MotViewController") as? MotViewController {
            navigationController?.setViewControllers([motViewController], animated: true)
        }
    }
    
    func navigateToScoreViewController(isWin: Bool, numberOfAttempts: Int) {
        if let scoreVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController {
            scoreVC.isWin = isWin
            scoreVC.numberOfAttempts = numberOfAttempts
            navigationController?.pushViewController(scoreVC, animated: true)
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
