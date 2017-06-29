//
//  AppDelegate.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/7/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //declare this property where it won't go out of scope relative to your listener
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let skipAction = UNNotificationAction(identifier: "SKIP_ACTION",
                                                title: "Skip",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let addNewStoreCategory = UNNotificationCategory(identifier: "addNewStore",
                                                    actions: [skipAction],
                                                    intentIdentifiers: [],
                                                    options: .customDismissAction)
        
        // Register the category.
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.setNotificationCategories([addNewStoreCategory])
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            
            // Enable or disable features based on authorization.
            if granted == true
            {
                print("Allow")
                application.registerForRemoteNotifications()
            }
            else
            {
                print("Don't Allow")
            }
        }
        application.applicationIconBadgeNumber = 0
        
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            // 2
            let aps = notification["aps"] as! [String: AnyObject]
            let storeId = aps["store_id"] as? String
            guard let alert = aps["alert"] as? [String: AnyObject] else { return false }
            let storeName = alert["title"] as! String
            let notificationObj = StorePushModel.init(storeId!, storeName)
            CoreDataManager.sharedInstance().saveNotification(notificationObj.storeName!, id: notificationObj.storeId!)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let notificationListV = storyboard.instantiateViewController(withIdentifier:"LatestShopListVC") as! LatestShopListVC
            let nv = UINavigationController(rootViewController:notificationListV)
            self.window?.rootViewController = nv
        }
        
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
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
    
    // MARK: - Core Data Saving support
    
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
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        if UserDefaults.standard.value(forKey: Constants.UserDefaultKey.DeviceToken) == nil {
            UserDefaults.standard.set(deviceTokenString, forKey: Constants.UserDefaultKey.DeviceToken)
            BookCitiesClient.sharedInstance().sendToken([Constants.RegTokenRequestKey.current_token:deviceTokenString as AnyObject,Constants.RegTokenRequestKey.prevtoken:"" as AnyObject,Constants.RegTokenRequestKey.platform:"iOS" as AnyObject], completionHandlerForLogin: { (response, error) in
             print(response ?? "no response")
            })
        }
        else if UserDefaults.standard.string(forKey: Constants.UserDefaultKey.DeviceToken) != deviceTokenString {
            BookCitiesClient.sharedInstance().sendToken([Constants.RegTokenRequestKey.current_token:deviceTokenString as AnyObject,Constants.RegTokenRequestKey.prevtoken:UserDefaults.standard.string(forKey: Constants.UserDefaultKey.DeviceToken) as AnyObject,Constants.RegTokenRequestKey.platform:"iOS" as AnyObject], completionHandlerForLogin: { (response, error) in
                print(response ?? "no response")
            })
            UserDefaults.standard.set(deviceTokenString, forKey: Constants.UserDefaultKey.DeviceToken)
        }
        else{
            
        }
        
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        let notification = data as! [String:AnyObject]
        let aps = notification["aps"] as! [String: AnyObject]
        let storeId = aps["store_id"] as? String
        guard let alert = aps["alert"] as? [String: AnyObject] else { return  }
        let storeName = alert["title"] as! String
        let notificationObj = StorePushModel.init(storeId!, storeName)
        CoreDataManager.sharedInstance().saveNotification(notificationObj.storeName!, id: notificationObj.storeId!)
//               print("Push notification received: \(data)")
        if application.applicationState != UIApplicationState.active
        {
            application.applicationIconBadgeNumber = 0
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let notificationListV = storyboard.instantiateViewController(withIdentifier:"LatestShopListVC") as! LatestShopListVC
            let nv = UINavigationController(rootViewController:notificationListV)
            self.window?.rootViewController = nv
        }
    }
    
//    func startReachableNotifier() {
//        do {
//            try reachability.startNotifier()
//        } catch {
//            print("Unable to start notifier")
//        }
//        
//    }
//    
//    func stopReachableNotifier(){
//        reachability.stopNotifier()
//    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
//    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        switch response.actionIdentifier {
//        case Constants.NotificationName.Action.skip:
//            print("Skip")
//        default:
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let notificationListV = storyboard.instantiateViewController(withIdentifier:"LatestShopListVC") as! LatestShopListVC
//            let nv = UINavigationController(rootViewController:notificationListV)
//            self.window?.rootViewController = nv
//        }
//        completionHandler()
//    }
}
