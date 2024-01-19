//
//  GestionnaireDeWord.swift
//  Pendix
//
//  Created by Faye on 2023-08-11.
//

import Foundation

class WordDownloader {
    static let shared = WordDownloader()
    
    func fetchRandomWord(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let randomWordArray = try? JSONSerialization.jsonObject(with: data) as? [String],
               let randomWord = randomWordArray.first {
                // Strip any extra characters from the word
                let strippedWord = randomWord.replacingOccurrences(of: "[\"']", with: "", options: .regularExpression)
                
                DispatchQueue.main.async {
                    completion(strippedWord)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
