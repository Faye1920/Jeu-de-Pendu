//
//  CoreDataStack.swift
//  Pendix
//
//  Created by Faye on 2023-09-12.
//

import Foundation
import CoreData

final class CoreDataStack {
    // MARK: - Singleton
    static let shared = CoreDataStack()
    
    // MARK: - Public
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.shared.persistentContainer.viewContext
    }

    
    // MARK: - Private
    private lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Pendix")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
  } })
      return container
    }()
  }
