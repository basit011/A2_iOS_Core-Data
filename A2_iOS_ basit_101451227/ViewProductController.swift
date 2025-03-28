//
//  ViewProductController.swift
//  A2_iOS_ basit_101451227
//
//  Created by Basit Ali on 2025-03-27.
//

import UIKit
import CoreData

class ViewProductController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Products"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
        
        
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
    }
    
    func fetchProducts() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            products = try context.fetch(fetchRequest)
            print("Fetched products: \(products)")
            tableView.reloadData()
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
}

extension ViewProductController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        let product = products[indexPath.row]
        
        // Show name, price, and description
        cell.textLabel?.text = "\(product.name ?? "Unnamed") - \(product.descriptionText ?? "No description available") - $\(String(format: "%.2f", product.price))"
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedProduct = products[indexPath.row]
        
        // Instantiate ProductDetailViewController
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailController") as? ProductDetailController {
            detailVC.product = selectedProduct
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}

