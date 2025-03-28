//
//  ProductDetailController.swift
//  A2_iOS_ basit_101451227
//
//  Created by Basit Ali on 2025-03-27.
//

import UIKit
import CoreData

class ProductDetailViewController: UIViewController {
    
    var product: Product!  // This will hold the Product passed from the previous screen
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Populate the labels with product details
        if let product = product {
            nameLabel.text = product.name ?? "No Name"
            descriptionLabel.text = product.description ?? "No Description"
            priceLabel.text = String(format: "$%.2f", product.price)
            providerLabel.text = product.provider ?? "Unknown Provider"
        }
        
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            // Optionally, update data if necessary when this screen appears again
//        }
    }
}
