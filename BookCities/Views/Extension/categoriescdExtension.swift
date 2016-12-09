//
//  categoriescdExtension.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 12/2/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension Categories {
    
    // MARK: - METHOD TO SAVE THE DATA ON CORE DATA
    func saveCategory(_ name: String , id: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Categories",
                                       in: managedContext)!
        
        let category = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
        
        // 3
        category.setValue(name, forKeyPath: "name")
        category.setValue(id, forKey: "id")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: -  FATCH DATA FROM CORE DATA
    func getCategories() -> Array<Any> {
        
        var data = Array<Any>()
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return Array()
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Categories")
        
        //3
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
    }
    
    // check whether category already exists or not
    func haveCategories() -> Bool {
        var count:Int?
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Categories")
        do{
            count = try managedContext.count(for: fetchRequest)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if count == 0 {
            return false
        }
        else{
            return true
        }
    }
    

}
