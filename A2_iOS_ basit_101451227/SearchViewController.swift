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

//            
//            var products: [Product] = []
//            var filteredProducts: [Product] = []
//            
//            override func viewDidLoad() {
//                super.viewDidLoad()
//                
//                tableView.delegate = self
//                tableView.dataSource = self
//                searchBar.delegate = self
//                
//                fetchProducts()
//            }
//            
//            func fetchProducts() {
//                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//                let context = appDelegate.persistentContainer.viewContext
//                
//                let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
//                
//                do {
//                    products = try context.fetch(fetchRequest)
//                    filteredProducts = products
//                    tableView.reloadData()
//                } catch {
//                    print("Failed to fetch products: \(error)")
//                }
//            }
//            
//            // MARK: - TableView Data Source
//            
//            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//                return filteredProducts.count
//            }
//            
//            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
//                let product = filteredProducts[indexPath.row]
//                cell.textLabel?.text = product.name
//                return cell
//            }
//            
//            // MARK: - TableView Delegate
//            
//            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                let selectedProduct = filteredProducts[indexPath.row]
//                performSegue(withIdentifier: "showProductDetail", sender: selectedProduct)
//            }
//            
//            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//                if segue.identifier == "showProductDetail",
//                   let destinationVC = segue.destination as? ProductDetailViewController,
//                   let selectedProduct = sender as? Product {
//                    destinationVC.product = selectedProduct
//                }
//            }
//            
//            // MARK: - SearchBar Delegate
//            
//            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//                if searchText.isEmpty {
//                    filteredProducts = products
//                } else {
//                    filteredProducts = products.filter { product in
//                        return product.name?.lowercased().contains(searchText.lowercased()) ?? false
//                    }
//                }
//                tableView.reloadData()
//            }
//        }
//


        
        var products = [Product]() 
        var filteredProducts = [Product]()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            searchBar.delegate = self
            
            // Load products from Core Data
            loadProducts()
        }
        
        
        func loadProducts(with request: NSFetchRequest<Product> = Product.fetchRequest()) {
            do {
                products = try context.fetch(request)
                filteredProducts = products
                tableView.reloadData()
            } catch let error {
                print("Error loading products: \(error.localizedDescription)") // More detailed error message
            }
        }

        
        // MARK: - UISearchBar Delegate
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Filter products based on search text
            if searchText.isEmpty {
                filteredProducts = products
            } else {
                let request: NSFetchRequest<Product> = Product.fetchRequest()
                request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText) // Assuming 'name' is an attribute of Product
                loadProducts(with: request)
            }
            tableView.reloadData()
        }
        
        // MARK: - UITableView Data Source & Delegate
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredProducts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
            let product = filteredProducts[indexPath.row]
            
            // Assuming the Product entity has a 'name' attribute
            cell.textLabel?.text = product.name
            
            return cell
        }
    }
