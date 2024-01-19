//
//  PreferenceViewController.swift
//  Pendix
//
//  Created by Faye on 2023-09-06.
//

import UIKit

class PreferenceViewController: UIViewController {
    
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var langueLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var langueSegment: UISegmentedControl!
    @IBOutlet weak var themePicker: UIPickerView!
    
    let userDefaults = UserDefaults.standard
    
    let LANGUE_KEY = "langueKey"
    
    let THEME_KEY = "themeKey"
    let DEFAULT_THEME = "defaultTheme"
    let GREEN_THEME = "greenTheme"
    let PURPLE_THEME = "purpleTheme"
    
    let colorOptions = ["Pink", "Green", "Purple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themePicker.dataSource = self
        themePicker.delegate = self
        
        // Définir la police du segment de langue
        let segmentFont = UIFont(name: "DarumadropOne-Regular", size: 16.0)
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: segmentFont ?? UIFont.systemFont(ofSize: 16.0)
        ]
        langueSegment.setTitleTextAttributes(attributes, for: .normal)

        // Définir la police de themePicker
        let pickerFont = UIFont(name: "DarumadropOne-Regular", size: 16.0)
        if let pickerView = themePicker.subviews.first as? UIPickerView {
            pickerView.subviews.forEach { view in
                if let label = view as? UILabel {
                    label.font = pickerFont ?? UIFont.systemFont(ofSize: 16.0)
                }
            }
        }

        // Do any additional setup after loading the view.
        updateLangue()
        updateTheme()
    }
    
    func updateLangue() {
        let selectedLanguage = userDefaults.string(forKey: LANGUE_KEY) ?? "Français"
        switch selectedLanguage {
        case "Français":
            titreLabel.text = "Préférences"
            langueLabel.text = "Langue"
            themeLabel.text = "Thème"
        case "English":
            titreLabel.text = "Preferences"
            langueLabel.text = "Language"
            themeLabel.text = "Theme"
        default:
            break
        }
    }
    
    @IBAction func langueSegmentChanged(_ sender: UISegmentedControl) {
        let selectedLanguageIndex = sender.selectedSegmentIndex
        switch selectedLanguageIndex {
            case 0:
                UserDefaults.standard.set("Français", forKey: LANGUE_KEY)
            case 1:
                UserDefaults.standard.set("English", forKey: LANGUE_KEY)
            default:
                break
        }
        updateLangue()
    }
    
    
    func updateTheme() {
        let theme = userDefaults.string(forKey: THEME_KEY)
        if(theme == DEFAULT_THEME) {
            view.backgroundColor = UIColor(red: 231/255, green: 165/255, blue: 159/255, alpha: 1.0)
        }
        else if(theme == GREEN_THEME) {
            view.backgroundColor = UIColor(red: 155/255, green: 203/255, blue: 148/255, alpha: 1.0)
        }
        else if(theme == PURPLE_THEME) {
            view.backgroundColor = UIColor(red: 158/255, green: 190/255, blue: 255/255, alpha: 1.0)
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

extension PreferenceViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedColorOption = colorOptions[row]
        var selectedTheme: String

        switch selectedColorOption {
        case "Default (Pink)":
            selectedTheme = DEFAULT_THEME
        case "Green":
            selectedTheme = GREEN_THEME
        case "Purple":
            selectedTheme = PURPLE_THEME
        default:
            selectedTheme = DEFAULT_THEME
        }

        UserDefaults.standard.set(selectedTheme, forKey: THEME_KEY)
        updateTheme()
    }
}
