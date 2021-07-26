//
//  AppDelegate.swift
//  MedLineSkinHealth
//
//  Copyright © 2021 Photon. All rights reserved.
//

import UIKit
import EncryptedCoreData
import Firebase
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    weak var screen : UIView? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        print("EnvConfig \(Environment.configuration(EnvKey.baseUrl))")
        // TODO: Keep this for testing
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        print("Document directory...\(documentsDirectory)")
        updateInitialViewController()
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    func updateInitialViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboardName = retrieveStoryboardName()
        let storyboard = UIStoryboard.init(name: storyboardName , bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:MedlineStoryboardIDConstant.kLoginViewControllerID) as! MedlineLoginViewController
        let navigationController = UINavigationController.init(rootViewController: viewController)
        self.window?.rootViewController = navigationController

        self.window?.makeKeyAndVisible()

    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: UIApplication Lifecycle
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Removing the blur effect on the captured screenshot
        application.removeBlurScreen()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Adding the blur effect on the captured screenshot
        application.blurScreen()
    }
    /*
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: URL = {
        //The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        //The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Medline_DigitalSkinHealth", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        //The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        //Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("Medline_DigitalSkinHealth.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            //Configure automatic migration.
            //let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            //try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
            
            let options : NSDictionary = [EncryptedStorePassphraseKey : retrieveProperString(retrieveString: MedlineKeychainData.retrieveMobileUniqueIDKey()), NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
            try coordinator.addPersistentStore(ofType: EncryptedStoreType, configurationName: nil, at: url, options: options as? [AnyHashable : Any])
            
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext: NSManagedObjectContext?
        if #available(iOS 10.0, *){
            managedObjectContext = self.persistentContainer.viewContext
        }else{
            //Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
            //NSMainQueueConcurrencyType is specifically for use with your application interface and can only be used on the main queue of an application.
            //NSPrivateQueueConcurrencyType configuration creates its own queue upon initialization and can be used only on that queue. Because the queue is private and internal to the NSManagedObjectContext instance.
            let coordinator = self.persistentStoreCoordinator
            managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext?.persistentStoreCoordinator = coordinator
        }
        return managedObjectContext!
    }()
    
    // MARK: - Core Data stack (iOS 10)
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Medline_DigitalSkinHealth")
        let containerOptions = [
            EncryptedStorePassphraseKey : retrieveProperString(retrieveString: MedlineKeychainData.retrieveMobileUniqueIDKey())
        ]
        do{
            /*try container.persistentStoreCoordinator.addPersistentStore(ofType: EncryptedStoreType, configurationName: nil, at: nil, options: containerOptions as? [AnyHashable : Any])*/
            
            let description = try EncryptedStore.makeDescription(options: containerOptions, configuration: nil)
            container.persistentStoreDescriptions = [description]
        }catch{
            print("ERROR IN ADD PERSISTENT STORE")
        }
        
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
    // MARK: - Core Data save
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
 */
}

