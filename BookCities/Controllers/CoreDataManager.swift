//
//  CoreDataManager.swift
//  BookCities
//
//  Created by Sushobhit_BuiltByBlank on 11/30/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import CoreData
class CoreDataManager: NSObject {
    
    // MARK: - SINGLETON CALSS METHOD TO GET GET SHARED OBJECT
    class func sharedInstance() -> CoreDataManager {
        struct Singleton {
            static var sharedInstance = CoreDataManager()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "BookCities")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - METHOD TO SAVE
    
    // Save  a Category ON CORE DATA
    func saveCategory(_ name: String , id: String) {
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return
        //        }
        // 1
        let managedContext =
            self.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: Constants.Entity.Category,
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
    
    // Save  a Notification ON CORE DATA
    func saveNotification(_ name: String , id: String) {
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return
        //        }
        // 1
        let managedContext =
            self.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: Constants.Entity.Notification,
                                       in: managedContext)!
        
        let notification = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
        
        // 3
        notification.setValue(name, forKeyPath: "name")
        notification.setValue(id, forKey: "id")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    // Save  a City ON CORE DATA
    func saveCity(_ name: String , id: String, stateId:String, countryId:String) {
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return
        //        }
        // 1
        let managedContext =
            self.persistentContainer.viewContext
        
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = managedContext
        // 2
        
        
        privateMOC.perform {
            let entity =
                NSEntityDescription.entity(forEntityName: Constants.Entity.City,
                                           in: privateMOC)!
            
            let city = NSManagedObject(entity: entity,
                                       insertInto: privateMOC)
            
            // 3
            city.setValue(name, forKeyPath: Constants.JSONCityResponseKey.Name)
            city.setValue(id, forKey: Constants.JSONCityResponseKey.Id)
            city.setValue(stateId, forKey: Constants.JSONCityResponseKey.State_id)
            city.setValue(countryId, forKey: Constants.JSONCityResponseKey.Country_id)
            // 4
            do {
                try privateMOC.save()
                managedContext.performAndWait {
                    do {
                        try managedContext.save()
                    } catch {
                        fatalError("Failure to save context: \(error)")
                    }
                }
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
        }
        
    }
    
    // SAVE a State ON CORE DATA
    func saveState(_ name: String , id: String, countryId:String) {
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return
        //        }
        // 1
        let managedContext =
            self.persistentContainer.viewContext
        
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = managedContext
        // 2
        
        
        privateMOC.perform {
            let entity =
                NSEntityDescription.entity(forEntityName: Constants.Entity.State,
                                           in: privateMOC)!
            
            let state = NSManagedObject(entity: entity,
                                        insertInto: privateMOC)
            
            // 3
            state.setValue(name, forKeyPath: Constants.JSONStateResponseKey.Name)
            state.setValue(id, forKey: Constants.JSONStateResponseKey.Id)
            state.setValue(countryId, forKey: Constants.JSONStateResponseKey.Country_id)
            // 4
            do {
                try privateMOC.save()
                managedContext.performAndWait {
                    do {
                        try managedContext.save()
                    } catch {
                        fatalError("Failure to save context: \(error)")
                    }
                }
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
        }
        
    }
    
    // SAVE a Country ON CORE DATA
    func saveCountry(_ name: String , id: String, sortName:String) {
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return
        //        }
        // 1
        let managedContext =
            self.persistentContainer.viewContext
        
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = managedContext
        // 2
        
        
        privateMOC.perform {
            let entity =
                NSEntityDescription.entity(forEntityName: Constants.Entity.Country,
                                           in: privateMOC)!
            
            let country = NSManagedObject(entity: entity,
                                          insertInto: privateMOC)
            
            // 3
            country.setValue(name, forKeyPath: Constants.JSONCountryResponseKey.Name)
            country.setValue(id, forKey: Constants.JSONCountryResponseKey.Id)
            country.setValue(sortName, forKey: Constants.JSONCountryResponseKey.SortName)
            // 4
            do {
                try privateMOC.save()
                managedContext.performAndWait {
                    do {
                        try managedContext.save()
                    } catch {
                        fatalError("Failure to save context: \(error)")
                    }
                }
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
        }
    }
    
    func saveStores(_ store: JSONStore,cityName:String) {
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return
        //        }
        // 1
        
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.Store)
        let predicate = NSPredicate(format: "id == %@", store.id!)
        fetchRequest.predicate = predicate
        do
        {
            let fetchResults = try managedContext.fetch(fetchRequest)
            for result in fetchResults{
                managedContext.delete(result as! Store)
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        let entity =
            NSEntityDescription.entity(forEntityName:Constants.Entity.Store,
                                       in: managedContext)!
        
        let storeEntity = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
        // 3
        storeEntity.setValue(store.name, forKeyPath: Constants.JSONStoreResponseKey.Name)
        storeEntity.setValue(store.id, forKey: Constants.JSONStoreResponseKey.Id)
        storeEntity.setValue(store.city, forKey: Constants.JSONStoreResponseKey.City)
        storeEntity.setValue(store.country, forKey: Constants.JSONStoreResponseKey.Country)
        storeEntity.setValue(store.address, forKey: Constants.JSONStoreResponseKey.Address)
        storeEntity.setValue(store.address_2, forKey: Constants.JSONStoreResponseKey.Address_2)
        storeEntity.setValue(store.books_category_ids, forKey: Constants.JSONStoreResponseKey.BookCategoryIds)
        storeEntity.setValue(store.is_museumshops, forKey: Constants.JSONStoreResponseKey.IsMuseumshops)
        storeEntity.setValue(store.is_new_books, forKey: Constants.JSONStoreResponseKey.IsNewBooks)
        storeEntity.setValue(store.is_used_books, forKey: Constants.JSONStoreResponseKey.IsUsedBooks)
        storeEntity.setValue(store.latitude, forKey: Constants.JSONStoreResponseKey.Latitude)
        storeEntity.setValue(store.longitude, forKey: Constants.JSONStoreResponseKey.Longitude)
        storeEntity.setValue(store.state, forKey: Constants.JSONStoreResponseKey.State)
        storeEntity.setValue(store.website, forKey: Constants.JSONStoreResponseKey.Website)
        storeEntity.setValue(store.working_hours, forKey: Constants.JSONStoreResponseKey.WorkingHours)
        storeEntity.setValue(store.zipcode, forKey: Constants.JSONStoreResponseKey.Zipcode)
        storeEntity.setValue(store.phone, forKey: Constants.JSONStoreResponseKey.phone)
        storeEntity.setValue(store.descriptions, forKey: Constants.JSONStoreResponseKey.descriptions)
        storeEntity.setValue(store.mon_from_hr, forKey: Constants.JSONStoreResponseKey.mon_from_hr)
        storeEntity.setValue(store.mon_from_mins, forKey: Constants.JSONStoreResponseKey.mon_from_mins)
        storeEntity.setValue(store.mon_to_hr, forKey: Constants.JSONStoreResponseKey.mon_to_hr)
        storeEntity.setValue(store.mon_to_mins, forKey: Constants.JSONStoreResponseKey.mon_to_mins)
        storeEntity.setValue(store.tue_from_hr, forKey: Constants.JSONStoreResponseKey.tue_from_hr)
        storeEntity.setValue(store.tue_from_mins, forKey: Constants.JSONStoreResponseKey.tue_from_mins)
        storeEntity.setValue(store.tue_to_hr, forKey: Constants.JSONStoreResponseKey.tue_to_hr)
        storeEntity.setValue(store.tue_to_mins, forKey: Constants.JSONStoreResponseKey.tue_to_mins)
        storeEntity.setValue(store.wed_from_hr, forKey: Constants.JSONStoreResponseKey.wed_from_hr)
        storeEntity.setValue(store.wed_from_mins, forKey: Constants.JSONStoreResponseKey.wed_from_mins)
        storeEntity.setValue(store.wed_to_hr, forKey: Constants.JSONStoreResponseKey.wed_to_hr)
        storeEntity.setValue(store.wed_to_mins, forKey: Constants.JSONStoreResponseKey.wed_to_mins)
        storeEntity.setValue(store.thurs_from_hr, forKey: Constants.JSONStoreResponseKey.thurs_from_hr)
        storeEntity.setValue(store.thurs_from_mins, forKey: Constants.JSONStoreResponseKey.thurs_from_mins)
        storeEntity.setValue(store.thurs_to_hr, forKey: Constants.JSONStoreResponseKey.thurs_to_hr)
        storeEntity.setValue(store.thurs_to_mins, forKey: Constants.JSONStoreResponseKey.thurs_to_mins)
        storeEntity.setValue(store.fri_from_hr, forKey: Constants.JSONStoreResponseKey.fri_from_hr)
        storeEntity.setValue(store.fri_from_mins, forKey: Constants.JSONStoreResponseKey.fri_from_mins)
        storeEntity.setValue(store.fri_to_hr, forKey: Constants.JSONStoreResponseKey.fri_to_hr)
        storeEntity.setValue(store.fri_to_mins, forKey: Constants.JSONStoreResponseKey.fri_to_mins)
        storeEntity.setValue(store.sat_from_hr, forKey: Constants.JSONStoreResponseKey.sat_from_hr)
        storeEntity.setValue(store.sat_from_mins, forKey: Constants.JSONStoreResponseKey.sat_from_mins)
        storeEntity.setValue(store.sat_to_hr, forKey: Constants.JSONStoreResponseKey.sat_to_hr)
        storeEntity.setValue(store.sat_to_mins, forKey: Constants.JSONStoreResponseKey.sat_to_mins)
        storeEntity.setValue(store.sun_to_hr, forKey: Constants.JSONStoreResponseKey.sun_to_hr)
        storeEntity.setValue(store.sun_to_mins, forKey: Constants.JSONStoreResponseKey.sun_to_mins)
        storeEntity.setValue(store.sun_from_hr, forKey: Constants.JSONStoreResponseKey.sun_from_hr)
        storeEntity.setValue(store.sun_from_mins, forKey: Constants.JSONStoreResponseKey.sun_from_mins)
        storeEntity.setValue(store.image1, forKey: Constants.JSONStoreResponseKey.Image1)
        storeEntity.setValue(store.image2, forKey: Constants.JSONStoreResponseKey.Image2)
        storeEntity.setValue(store.image3, forKey: Constants.JSONStoreResponseKey.Image3)
        storeEntity.setValue(store.image4, forKey: Constants.JSONStoreResponseKey.Image4)
        storeEntity.setValue(true, forKey: Constants.JSONStoreResponseKey.IsFavorate)                                         
        storeEntity.setValue(cityName, forKey: Constants.CDStoreKey.CityName)
        storeEntity.setValue(store.by_appointment, forKey: Constants.JSONStoreResponseKey.by_appointment)
        storeEntity.setValue(store.mon_by_appointment, forKey: Constants.JSONStoreResponseKey.mon_by_appointment)
        storeEntity.setValue(store.tue_by_appointment, forKey: Constants.JSONStoreResponseKey.tue_by_appointment)
        storeEntity.setValue(store.wed_by_appointment, forKey: Constants.JSONStoreResponseKey.wed_by_appointment)
        storeEntity.setValue(store.thurs_by_appointment, forKey: Constants.JSONStoreResponseKey.thurs_by_appointment)
        storeEntity.setValue(store.on_holiday, forKey: Constants.JSONStoreResponseKey.on_holiday)
        storeEntity.setValue(store.holiday_from, forKey: Constants.JSONStoreResponseKey.holiday_from)
        storeEntity.setValue(store.holiday_to, forKey: Constants.JSONStoreResponseKey.holiday_to)
        storeEntity.setValue(store.holiday_message, forKey: Constants.JSONStoreResponseKey.holiday_message)
        storeEntity.setValue(store.mon_lunch_from_hr, forKey: Constants.JSONStoreResponseKey.mon_lunch_from_hr)
        storeEntity.setValue(store.tue_lunch_from_hr, forKey: Constants.JSONStoreResponseKey.tue_lunch_from_hr)
        storeEntity.setValue(store.wed_lunch_from_hr, forKey: Constants.JSONStoreResponseKey.wed_lunch_from_hr)
        storeEntity.setValue(store.thurs_lunch_from_hr, forKey: Constants.JSONStoreResponseKey.thurs_lunch_from_hr)
        storeEntity.setValue(store.fri_lunch_from_hr, forKey: Constants.JSONStoreResponseKey.fri_lunch_from_hr)
        storeEntity.setValue(store.sat_lunch_from_hr, forKey: Constants.JSONStoreResponseKey.sat_lunch_from_hr)
        storeEntity.setValue(store.sun_lunch_from_hr, forKey: Constants.JSONStoreResponseKey.sun_lunch_from_hr)
        storeEntity.setValue(store.mon_lunch_from_mins, forKey: Constants.JSONStoreResponseKey.mon_lunch_from_mins)
        storeEntity.setValue(store.tue_lunch_from_mins, forKey: Constants.JSONStoreResponseKey.tue_lunch_from_mins)
        storeEntity.setValue(store.wed_lunch_from_mins, forKey: Constants.JSONStoreResponseKey.wed_lunch_from_mins)
        storeEntity.setValue(store.thurs_lunch_from_mins, forKey: Constants.JSONStoreResponseKey.thurs_lunch_from_mins)
        storeEntity.setValue(store.fri_lunch_from_mins, forKey: Constants.JSONStoreResponseKey.fri_lunch_from_mins)
        storeEntity.setValue(store.sat_lunch_from_mins, forKey: Constants.JSONStoreResponseKey.sat_lunch_from_mins)
        storeEntity.setValue(store.sun_lunch_from_mins, forKey: Constants.JSONStoreResponseKey.sun_lunch_from_mins)
        storeEntity.setValue(store.mon_lunch_to_hr, forKey: Constants.JSONStoreResponseKey.mon_lunch_to_hr)
        storeEntity.setValue(store.tue_lunch_to_hr, forKey: Constants.JSONStoreResponseKey.tue_lunch_to_hr)
        storeEntity.setValue(store.wed_lunch_to_hr, forKey: Constants.JSONStoreResponseKey.wed_lunch_to_hr)
        storeEntity.setValue(store.thurs_lunch_to_hr, forKey: Constants.JSONStoreResponseKey.thurs_lunch_to_hr)
        storeEntity.setValue(store.fri_lunch_to_hr, forKey: Constants.JSONStoreResponseKey.fri_lunch_to_hr)
        storeEntity.setValue(store.sat_lunch_to_hr, forKey: Constants.JSONStoreResponseKey.sat_lunch_to_hr)
        storeEntity.setValue(store.sun_lunch_to_hr, forKey: Constants.JSONStoreResponseKey.sun_lunch_to_hr)
        storeEntity.setValue(store.mon_lunch_to_mins, forKey: Constants.JSONStoreResponseKey.mon_lunch_to_mins)
        storeEntity.setValue(store.tue_lunch_to_mins, forKey: Constants.JSONStoreResponseKey.tue_lunch_to_mins)
        storeEntity.setValue(store.wed_lunch_to_mins, forKey: Constants.JSONStoreResponseKey.wed_lunch_to_mins)
        storeEntity.setValue(store.thurs_lunch_to_mins, forKey: Constants.JSONStoreResponseKey.thurs_lunch_to_mins)
        storeEntity.setValue(store.fri_lunch_to_mins, forKey: Constants.JSONStoreResponseKey.fri_lunch_to_mins)
        storeEntity.setValue(store.sat_lunch_to_mins, forKey: Constants.JSONStoreResponseKey.sat_lunch_to_mins)
        storeEntity.setValue(store.sun_lunch_to_mins, forKey: Constants.JSONStoreResponseKey.sun_lunch_to_mins)
        // 4
        do {
            try managedContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

    //MARK: -  FATCH DATA FROM CORE DATA
    
    //Fatch Categories
    func getCategories() -> Array<Any> {
        var data = Array<Any>()
        //1
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return Array()
        //        }
        
        let managedContext =
            self.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Category)
        
        //3
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
    }
    
    //Fatch Notification
    func getNotifications() -> Array<Any> {
        var data = Array<Any>()
        //1
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return Array()
        //        }
        
        let managedContext =
            self.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Notification)
        
        //3
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
    }
    
    //Fatch Category by Id
    func getCategoryName(id:String) -> String {
        var data = String()
        
        let managedContext =
            self.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Category)
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            data = result[0].value(forKey: "name") as! String
            } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
    }
    
    // Fatch Cities
    func getCities() -> Array<Any> {
        
        var data = Array<Any>()
        
        //1
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return Array()
        //        }
        
        let managedContext =
            self.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.City)
        //3
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
    }
    
    // Fatch Stores
    func getStores() -> Array<Any> {
        
        var data = Array<Any>()
        
        //1
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return Array()
        //        }
        
        let managedContext =
            self.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Store)
        //3
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
    }
    
    // Fatch favorate Store from coreData 
    func getFavorateStores() ->Array<Any>{
        var data = Array<Any>()
        let managedContext =
            self.persistentContainer.viewContext
        // 1
        let idAttribute = "isFavorate"
        // 2
        let idPredicateFilter = true
        //3
        let idPredicate = NSPredicate(format: "%K == %@",   idAttribute , NSNumber(booleanLiteral: idPredicateFilter))

        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Store)
        fetchRequest.predicate = idPredicate
        //3
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
    }
    // Fatch State
    func getState() -> Array<Any> {
        var data = Array<Any>()
        
        //1
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return Array()
        //        }
        
        let managedContext =
            self.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.State)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        //3
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
        
    }
    
    // Fatch Country
    func getCountry() -> Array<Any> {
        var data = Array<Any>()
        
        //1
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return Array()
        //        }
        
        let managedContext =
            self.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Country)
        //3
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return data
        
    }

    // MARK: - Check whether Record already exists or not
    
    func haveCategories() -> Bool {
        var count:Int?
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return false
        //        }
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Category)
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
    
    func haveCity() -> Bool {
        var count:Int?
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return false
        //        }
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.City)
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

    func haveStore() -> Bool {
        var count:Int?
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return false
        //        }
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Store)
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

    func haveState() -> Bool {
        var count:Int?
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return false
        //        }
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.State)
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
    
    func haveCountry() -> Bool {
        var count:Int?
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return false
        //        }
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.Country)
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
    
    // MARK: - Check ID in Record is already exists or not
    
    
    func haveCity(_ Id: String) -> Bool {
        var count:Int?
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return false
        //        }
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.Entity.City)
        let predicate = NSPredicate(format: "id == %@",Id)
        fetchRequest.predicate = predicate
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
    
    func haveStore(_ Id: String) -> Bool {
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return false
        //        }
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.Store)
        let predicate = NSPredicate(format: "id == %@", Id)
        fetchRequest.predicate = predicate
        do
        {
            let fetchResults = try managedContext.fetch(fetchRequest)
            if fetchResults.count > 0 {
                return true
            }
            else{
                return false
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
        
    }
    
    func haveCategory(_ Id: String) -> Bool {
        //        guard let appDelegate =
        //            UIApplication.shared.delegate as? AppDelegate else {
        //                return false
        //        }
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.Category)
        let predicate = NSPredicate(format: "id == %@", Id)
        fetchRequest.predicate = predicate
        do
        {
            let fetchResults = try managedContext.fetch(fetchRequest)
            if fetchResults.count > 0 {
                return true
            }
            else{
                return false
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
        
    }

    // MARK: - Get the Record by ID
    
    func getStore(_ Id: String) -> Store {
        var data:Store!
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.Store)
        let predicate = NSPredicate(format: "id == %@", Id)
        fetchRequest.predicate = predicate
        
        do
        {
            let fetchResults = try managedContext.fetch(fetchRequest)
            if fetchResults.count > 0 {
               data = fetchResults[0] as! Store
            }
            else{
                return data
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return data
        }
        return data
    }
    
    func getState(_ Id: String) -> State {
        var data:State!
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.State)
        let predicate = NSPredicate(format: "id == %@", Id)
        fetchRequest.predicate = predicate
        
        do
        {
            let fetchResults = try managedContext.fetch(fetchRequest)
            if fetchResults.count > 0 {
                data = fetchResults[0] as! State
            }
            else{
                return data
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return data
        }
        return data
    }
    
    func getCountry(_ Id: String) -> Country {
        var data:Country!
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.Country)
        let predicate = NSPredicate(format: "id == %@", Id)
        fetchRequest.predicate = predicate
        
        do
        {
            let fetchResults = try managedContext.fetch(fetchRequest)
            if fetchResults.count > 0 {
                data = fetchResults[0] as! Country
            }
            else{
                return data
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return data
        }
        return data
    }

    //MARK:-  Delete record from CoreData
    
    func deleteStore(storeID:String)
    {
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.Store)
        let predicate = NSPredicate(format: "id == %@", storeID)
        fetchRequest.predicate = predicate
        do
        {
            let fetchResults = try managedContext.fetch(fetchRequest)
            for result in fetchResults{
                managedContext.delete(result as! Store)
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        do
        {
            try managedContext.save()
        }
        catch let error as NSError {
            fatalError("Failure to save context: \(error)")
        }
    }

    //  delete Notification from coreData
    func deleteNotification(_ notificationId:String)
    {
        let managedContext =
            self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entity.Notification)
        let predicate = NSPredicate(format: "id == %@", notificationId)
        fetchRequest.predicate = predicate
        do
        {
            let fetchResults = try managedContext.fetch(fetchRequest)
            for result in fetchResults{
                managedContext.delete(result as! Notification)
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        do
        {
            try managedContext.save()
        }
        catch let error as NSError {
            fatalError("Failure to save context: \(error)")
        }
    }

}
