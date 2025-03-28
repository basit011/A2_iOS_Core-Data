//
//  ProductDetailController.swift
//  A2_iOS_ basit_101451227
//
//  Created by Basit Ali on 2025-03-27.
//

import UIKit
import CoreData

class ProductDetailController: UIViewController {
    
    
    // This will hold the Product passed from the previous screen
    var product: Product!
    
    
    @IBOutlet weak var IDLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!

    @IBOutlet weak var descriptionLabel: UITextField!
    
    @IBOutlet weak var priceLabel: UITextField!
    
    
    @IBOutlet weak var providerLabel: UITextField!
    
    
        var products: [Product] = []
        var currentIndex: Int = 0

        override func viewDidLoad() {
            super.viewDidLoad()
            fetchProducts()
            showProduct(at: currentIndex)
        }

        func fetchProducts() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
            
            do {
                products = try context.fetch(fetchRequest)
            } catch {
                print("Error fetching products: \(error)")
            }
        }
    
    func showProduct(at index: Int) {
        guard !products.isEmpty else {
            nameLabel.text = "No products found"
            return
        }

        let product = products[index]
        
        IDLabel.text = "ID: \(product.id?.uuidString ?? "No ID available")"
        
        nameLabel.text = "Name: \(product.name ?? "No name available")"
        
        descriptionLabel.text = "Description: \(product.descriptionText ?? "No description available")"
        
        priceLabel.text = "Price: $\(String(format: "%.2f", product.price))"
        
        providerLabel.text = "Provider: \(product.provider ?? "N/A")"
    }

        @IBAction func nextProduct(_ sender: UIButton) {
            if currentIndex < products.count - 1 {
                currentIndex += 1
                showProduct(at: currentIndex)
            }
        }

        @IBAction func previousProduct(_ sender: UIButton) {
            if currentIndex > 0 {
                currentIndex -= 1
                showProduct(at: currentIndex)
            }
        }
    }
