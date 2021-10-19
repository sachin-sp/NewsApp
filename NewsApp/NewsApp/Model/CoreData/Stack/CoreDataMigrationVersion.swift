//
//  CoreDataMigrationVersion.swift
//  RestaurantPOS
//
//  Created by Vijay A on 27/09/21.
//


import CoreData

enum CoreDataMigrationVersion: String, CaseIterable {
    case version1 = "NewsApp"
    
    // MARK: - Current
    
    static var current: CoreDataMigrationVersion {
        guard let latest = allCases.last else {
            fatalError("no model versions found")
        }
        
        return latest
    }
    
    // MARK: - Migration
    
    func nextVersion() -> CoreDataMigrationVersion? {
        switch self {
        case .version1:
            return nil
//        case .version2:
//            return nil
        }
    }
}
