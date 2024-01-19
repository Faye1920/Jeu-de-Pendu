//
//  FilmViewController.swift
//  Pendix
//
//  Created by Faye on 2023-08-11.
//

import UIKit

class FilmViewController: UIViewController {
    
    @IBOutlet weak var devinnetteLabel: UILabel!
    @IBOutlet weak var userInputField: UITextField!
    @IBOutlet weak var userUsedLettres: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var hangmanView: UIImageView!
    
    var mode: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MovieDownloader.shared.downloadMovie(withID: listeFilms.randomElement()!) { (film) in
            JeuPendu.shared.jouer(avec: film!)
            self.devinnetteLabel.text = JeuPendu.shared.devinette
            self.pointsLabel.text = "Pointage: \(JeuPendu.shared.erreurs)"
        }
        
        UserDefaults.standard.set("Film", forKey: "gameType")
        
        // There is no need to save scores here as the game is not complete
        // ScoreStore.saveScore(username: <username>, gameType: "Film", score: <score>)
        
        print("Type: \(mode)")
        
    }
    
    @IBAction func validateBtn(_ sender: Any) {
        if let res = userInputField.text, res.count == 1 {
            // Check if the input is a letter or a digit
            if !CharacterSet.alphanumerics.isSuperset(of: CharacterSet(charactersIn: res)) {
                displayInputErrorAlert()
                return
            }
            
            JeuPendu.shared.verifier(lettre: Character(res))
            devinnetteLabel.text = JeuPendu.shared.devinette
        }
        userInputField.text = ""
        userUsedLettres.text = JeuPendu.shared.lettreUtilisees
        pointsLabel.text = "Erreurs: \(JeuPendu.shared.erreurs)"
        hangmanView.image = JeuPendu.shared.image
        
        if let fin = JeuPendu.shared.verifierFinDePartie() {
            print("DB Gagné: ", fin)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let successVC = storyboard.instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController {
                let currentNbErrors = JeuPendu.shared.getCurrentNbErrors()
                
                successVC.numberOfAttempts = 0
                successVC.cntErrors = currentNbErrors
                
                navigationController?.pushViewController(successVC, animated: true)
            }
        }
    }
    
    
    // Add this method to display the input error alert
    func displayInputErrorAlert() {
        let alertController = UIAlertController(title: "Erreur", message: "Veuillez saisir les lettres A - Z ou les chiffres 0 - 9.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Oui", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    // Method to navigate to SuccessViewController
    func navigateToSuccessViewController(isWin: Bool, numberOfAttempts: Int) {
        if let successVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController {
            successVC.isWin = isWin
            successVC.numberOfAttempts = numberOfAttempts
            navigationController?.pushViewController(successVC, animated: true)
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

