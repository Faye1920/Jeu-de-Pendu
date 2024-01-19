//
//  JoueurViewController.swift
//  Pendix
//
//  Created by Faye on 2023-08-11.
//

import UIKit

class JoueurViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup, if needed
    }
    
    @IBAction func demarrerBtnTapped(_ sender: Any) {
        if let name = nameTextField.text, name.count >= 3 {
            print("userName: \(name)")
            
            // Save the user's name to UserDefaults
            UserDefaults.standard.set(name, forKey: "username")
            
            // Navigate to FilmViewController
            UserDefaults.standard.set("Mot", forKey: "gameType")
            
            // Name length is sufficient, navigate to MotViewController
            navigateToMotViewController()
        } else {
            // Name length is insufficient, show error alert
            showNameLengthErrorAlert()
        }
    }
    
    // Function to navigate to MotViewController
    func navigateToMotViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let motViewController = storyboard.instantiateViewController(withIdentifier: "MotViewController") as? MotViewController {
            motViewController.mode = "Mot"
            navigationController?.pushViewController(motViewController, animated: true)
        }
    }
    
    
    // Function to show name length error alert
    func showNameLengthErrorAlert() {
        let alert = UIAlertController(title: "Erreur", message: "\nVeuillez entrez au moins 3 caractères.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
