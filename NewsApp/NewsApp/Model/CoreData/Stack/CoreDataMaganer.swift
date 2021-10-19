//
//  CoreDataMaganer.swift
//  RestaurantPOS
//
//  Created by Vijay A on 27/09/21.
//

import Foundation

import Foundation
import CoreData


class CoreDataMaganer: NSObject {
    
    static let shared = CoreDataMaganer()
    
    func saveContest(){
        do {
            try CoreDataStack.shared.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    func deleteCoreData(_ entity: String) {
        let context = CoreDataStack.shared.persistentContainer.viewContext

           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
           if let result = try? context.fetch(fetchRequest) {
               for object in result {
                   if let _object = object as? NSManagedObject {
                       context.delete(_object)
                   }
               }
               do {
                   try context.save() // <- remember to put this :)
               } catch let err{
                   // Do something... fatalerror
                   print(err.localizedDescription)
               }
           }
       }
    

}

//MARK: MASTERDATA TAX

extension CoreDataMaganer {
    
    func insertBookmarkArticle(article:[String: Any]){
        guard let jsonData = try? JSONSerialization.data(
        withJSONObject: article,
        options: []) else {
            return
        }
        do {
            guard let codableContext = CodingUserInfoKey.init(rawValue: "context") else {
                               fatalError("Failed context")
            }
            let manageObjContext = CoreDataStack.shared.persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codableContext] = manageObjContext
            // Parse JSON data
            _ = try decoder.decode(CDArticle.self, from: jsonData)
                   ///context save
             try manageObjContext.save()
             } catch let error {
                   print("Error ->\(error.localizedDescription)")
            }
    }
    
    
    func fetchBookmarkArticles() -> [CDArticle] {
        let manageObjContext =  CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<CDArticle> = CDArticle.fetchRequest()
        do {
            let arrayOfList = try manageObjContext.fetch(fetchRequest)
            return arrayOfList

        } catch let error {
            print(error)
            return []
        }
    }
    
    
    func deleteBookmarkArticle(id: String) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDArticle")
        fetchRequest.predicate = NSPredicate(format: "orderDetails.orderNo = %@")
        do
        {
            let test = try context.fetch(fetchRequest)
            if test.count > 0 {
                let objectToDelete = test[0] as! NSManagedObject
                context.delete(objectToDelete)
                do{
                    try context.save()
                }
                catch
                {
                    print(error)
                }
            }
        }
        catch
        {
            print(error)
        }
    }
    
}


