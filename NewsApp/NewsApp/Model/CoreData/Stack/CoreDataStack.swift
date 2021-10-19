//
//  CoreDataStack.swift
//  RestaurantPOS
//
//  Created by Vijay A on 27/09/21.
//

import Foundation
import CoreData


class CoreDataStack: NSObject {
    
    static let shared = CoreDataStack()
    
    let migrator: CoreDataMigratorProtocol
    private let storeType: String
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "NewsApp")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.shouldInferMappingModelAutomatically = false //inferred mapping will be handled else where
        description?.shouldMigrateStoreAutomatically = false
        description?.type = storeType
        
        return persistentContainer
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        
        return context
    }()
    
    // MARK: - Init
    
    init(storeType: String = NSSQLiteStoreType, migrator: CoreDataMigratorProtocol = CoreDataMigrator()) {
        self.storeType = storeType
        self.migrator = migrator
    }
    
    // MARK: - SetUp
    
    func setup(completion: @escaping () -> Void) {
        loadPersistentStore {
            completion()
        }
    }
    
    // MARK: - Loading
    
    private func loadPersistentStore(completion: @escaping () -> Void) {
        migrateStoreIfNeeded {
            self.persistentContainer.loadPersistentStores { description, error in
                guard error == nil else {
                    fatalError("was unable to load store \(error!)")
                }
                
                completion()
            }
        }
    }
    
    private func migrateStoreIfNeeded(completion: @escaping () -> Void) {
        guard let storeURL = persistentContainer.persistentStoreDescriptions.first?.url else {
            fatalError("persistentContainer was not set up properly")
        }
        
        if migrator.requiresMigration(at: storeURL, toVersion: CoreDataMigrationVersion.current) {
            DispatchQueue.global(qos: .userInitiated).async {
                self.migrator.migrateStore(at: storeURL, toVersion: CoreDataMigrationVersion.current)
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else {
            completion()
        }
    }
   
}

extension CoreDataStack {
    
    func applicationDocumentsDirectory() -> URL? {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "yo.BlogReaderApp" in the application's documents directory.
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
            return url
        }
        return nil
    }
    
}
