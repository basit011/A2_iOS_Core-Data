//
//  AppDelegate.swift
//  A2_iOS_ basit_101451227
//
//  Created by Basit Ali on 2025-03-24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preLoadProductsIfNeeded()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "A2_iOS__basit_101451227")
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

    
    
    func preLoadProductsIfNeeded() {
        let context = persistentContainer.viewContext
        
        // Check if there are already products in the database
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let products = try context.fetch(fetchRequest)
            
            // If there are no products, insert 10 products
            if products.isEmpty {
                let sampleProducts = [
                    ("P001", "iPhone 15", "Latest Apple iPhone with A16 chip", 999.99, "Apple"),
                    ("P002", "OPPO Find X7 Ultra", "OPPO's flagship smartphone", 1269.99, "OPPO"),
                    ("P003", "MacBook Pro", "Apple's premium laptop", 2999.99, "Apple"),
                    ("P004", "Xbox Series X", "Microsoft's powerful gaming console", 499.99, "Microsoft"),
                    ("P005", "Xiaomi 14 Ultra", "Xiaomi Flagship Phone", 1399.99, "Xiaomi"),
                    ("P006", "AirPods Pro", "Wireless noise-canceling earbuds", 249.99, "Apple"),
                    ("P007", "Apple Watch Ultra", "Premium smartwatch for fitness lovers", 799.99, "Apple"),
                    ("P008", "Dell XPS 13", "Ultra-thin powerful laptop", 1299.99, "Dell"),
                    ("P009", "Logitech MX Master 3", "High-end ergonomic mouse", 99.99, "Logitech"),
                    ("P010", "Samsung Galaxy S25", "Samsung's flagship smartphone", 1499.99, "Samsung")
                ]
                
                // Loop through the array of products and insert them into Core Data
                for (id, name, description, price, provider) in sampleProducts {
                    let product = Product(context: context)
                    product.name = name
                    product.descriptionText = description
                    product.price = price
                    product.provider = provider
                }
                
                // Save the context after inserting products
                try context.save()
            }
        } catch {
            print("Error fetching or inserting products: \(error)")
        }
    }

    
    
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

}

