//
//  ScoreStore.swift
//  Pendix
//
//  Created by Faye on 2023-09-12.
//

import Foundation
import CoreData

// MARK: - Core Data
class ScoreStore {
    
    static func saveScore(username: String, gameType: String, score: Int) {
        let currentContext = CoreDataStack.shared.viewContext
        let newScore = Score(context: currentContext)
        
        newScore.username = username
        newScore.gameType = gameType
        newScore.score = Int16(score)
        
        // Tentative de sauvegarde de l'entité dans Core Data
        do {
            try currentContext.save()
            print("Score sauvegardée avec succès!")
        } catch let error as NSError {
            print("Impossible de sauvegarder le score. \(error), \(error.userInfo)")
        }
    }

    
    static func getScores( completion: ([Score]) -> Void) {
        
        let request: NSFetchRequest<Score> = Score.fetchRequest()
        
        do {
            let scores = try CoreDataStack.shared.viewContext.fetch(request)
            completion(scores)
        } catch {
            completion([])
        }
        
        
    }
}

