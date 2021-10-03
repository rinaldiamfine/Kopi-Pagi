//
//  PersistenceController.swift
//  Kopi Pagi
//
//  Created by Rinaldi LNU on 03/10/21.
//

import Foundation

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "DataModel")
        container.loadPersistentStores { storeDescription, error in
            if let err = error as NSError? {
                print("Error \(err.userInfo)")
            }
        }
        return container
    }()
    
    func saveData(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func deleteData(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        saveData(completion: completion)
    }
}
