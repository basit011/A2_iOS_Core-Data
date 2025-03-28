//
//  SearchViewController.swift
//  A2_iOS_ basit_101451227
//
//  Created by Basit Ali on 2025-03-28.
//


import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var selectedProductLabel: UILabel!

        var products = [Product]()
        var filteredProducts = [Product]()

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            searchBar.delegate = self
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
            
            // Initially hide the table view
            tableView.isHidden = true
            
            // Load products from Core Data
            loadProducts()
        }
        

        func loadProducts(with request: NSFetchRequest<Product>? = Product.fetchRequest()) {
            do {
                let result = try context.fetch(request!)
                self.filteredProducts = result
                tableView.isHidden = result.isEmpty
                tableView.reloadData()
            } catch {
                print("Error fetching products: \(error)")
            }
        }


        // MARK: - UISearchBar Delegate
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Always show the table view when the user starts typing
            tableView.isHidden = false
            
            if searchText.isEmpty {
                filteredProducts = products
            } else {
               // Apply search filter with multiple words
                let request: NSFetchRequest<Product> = Product.fetchRequest()
                request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
            
                loadProducts(with: request)
            }

            // Reload the table view after filtering
            tableView.reloadData()
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // Dismiss the keyboard when the "Enter" key is pressed
            searchBar.resignFirstResponder()
            
            // Optionally, update UI or perform other actions (e.g., load details)
            print("Search button pressed with text: \(searchBar.text ?? "")")
            
            let request: NSFetchRequest<Product> = Product.fetchRequest()
            if let searchText = searchBar.text, !searchText.isEmpty {
                request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
                loadProducts(with: request)
            } else {
                // If search text is empty, reload all products
                loadProducts()
            }
        }
        
        // MARK: - UITableView Data Source & Delegate
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredProducts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
            let product = filteredProducts[indexPath.row]
            cell.textLabel?.text = product.name
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedProduct = filteredProducts[indexPath.row]
            
            selectedProductLabel.text = "Selected Product: \(selectedProduct.name ?? "No name")"
            
            // Deselect the row after selection
            tableView.deselectRow(at: indexPath, animated: true)
        }
}
