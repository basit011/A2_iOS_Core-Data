//
//  ProductDetailController.swift
//  A2_iOS_ basit_101451227
//
//  Created by Basit Ali on 2025-03-27.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var product: Product!  // This will hold the Product passed from the previous screen
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate the labels with product details
        nameLabel.text = product.productName ?? "No Name"
        descriptionLabel.text = product.productDescription ?? "No Description"
        priceLabel.text = "$\(product.productPrice, specifier: "%.2f")"
        providerLabel.text = product.productProvider ?? "Unknown Provider"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Optionally, update data if necessary when this screen appears again
    }
}
