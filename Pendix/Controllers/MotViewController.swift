//
//  MotViewController.swift
//  Pendix
//
//  Created by Faye on 2023-08-11.
//

import UIKit

class MotViewController: UIViewController {
    
    @IBOutlet weak var devinnetteLabel: UILabel!
    @IBOutlet weak var userInputField: UITextField!
    @IBOutlet weak var userUsedLettres: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var hangmanView: UIImageView!
    
    var mode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WordDownloader.shared.fetchRandomWord { (word) in
            if let word = word {
                JeuMot.shared.jouer(avec: word) // Pass the word string here
                self.devinnetteLabel.text = JeuMot.shared.devinette
                self.pointsLabel.text = "Pointage: \(JeuMot.shared.erreurs)"
            } else {
                // Handle the case where fetching the word from API failed
            }
        }
        
        UserDefaults.standard.set("Mot", forKey: "gameType")
        
        // There is no need to save scores here as the game is not complete
        // ScoreStore.saveScore(username: <username>, gameType: "Film", score: <score>)
        
        print("Type: \(mode)")
        
        
    }
    
    @IBAction func validateBtn(_ sender: Any) {
        if let res = userInputField.text, res.count == 1 {
            // Check if the input is a letter
            if !CharacterSet.letters.contains(UnicodeScalar(res)!) {
                displayInputErrorAlert()
                return
            }
            
            JeuMot.shared.verifier(lettre: Character(res))
            devinnetteLabel.text = JeuMot.shared.devinette
        }
        userInputField.text = ""
        userUsedLettres.text = JeuMot.shared.lettreUtilisees
        pointsLabel.text = "Erreurs: \(JeuMot.shared.erreurs)"
        hangmanView.image = JeuMot.shared.image
        
        if let fin = JeuMot.shared.verifierFinDePartie() {
            print("DB Gagné: ", fin)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let reussiVC = storyboard.instantiateViewController(withIdentifier: "ReussiViewController") as? ReussiViewController {
                let currentNbErrors = JeuMot.shared.getCurrentNbErrors()
                
                reussiVC.numberOfAttempts = 0
                reussiVC.cntErrors = currentNbErrors
                
                navigationController?.pushViewController(reussiVC, animated: true)
            }
        }
    }
    
    // Add this method to display the input error alert
    func displayInputErrorAlert() {
        let alertController = UIAlertController(title: "Erreur", message: "Seules les lettres de A à Z peuvent être saisies, veuillez réessayer.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Oui", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    // Method to navigate to ReussiViewController
    func navigateToReussiViewController(isWin: Bool, numberOfAttempts: Int) {
        if let reussiVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReussiViewController") as? ReussiViewController {
            reussiVC.isWin = isWin
            reussiVC.numberOfAttempts = numberOfAttempts
            navigationController?.pushViewController(reussiVC, animated: true)
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
