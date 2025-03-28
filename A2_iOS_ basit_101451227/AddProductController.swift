//
//  AddProductController.swift
//  A2_iOS_ basit_101451227
//
//  Created by Basit Ali on 2025-03-27.
//

import UIKit
import CoreData

class AddProductController: UIViewController, UITextFieldDelegate {

        
        @IBOutlet weak var nameTextField: UITextField!
        @IBOutlet weak var descriptionTextField: UITextField!
        @IBOutlet weak var priceTextField: UITextField!
        @IBOutlet weak var providerTextField: UITextField!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            nameTextField.delegate = self
            descriptionTextField.delegate = self
            priceTextField.delegate = self
            providerTextField.delegate = self
        }
        
        @IBAction func saveButtonTapped(_ sender: UIButton) {
            view.endEditing(true)
            
            guard let name = nameTextField.text, !name.isEmpty,
                  let description = descriptionTextField.text, !description.isEmpty,
                  let priceText = priceTextField.text, let price = Double(priceText),
                  let provider = providerTextField.text, !provider.isEmpty else {
                showAlert(message: "Please fill all fields correctly.")
                return
            }
            
            // Get the Core Data context
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                showAlert(message: "Unable to get app delegate.")
                return
            }
            let context = appDelegate.persistentContainer.viewContext
            
            // Create new Product object
            let newProduct = Product(context: context)
            newProduct.id = UUID()
            newProduct.name = name
            newProduct.descriptionText = description
            newProduct.price = price
            newProduct.provider = provider
            
            do {
                try context.save()
                showAlert(message: "Product saved successfully!", dismiss: true)
            } catch {
                showAlert(message: "Failed to save product: \(error.localizedDescription)")
            }
        }
        
        // MARK: - Alert Helper
        func showAlert(message: String, dismiss: Bool = false) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            if dismiss {
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                })
            } else {
                alert.addAction(UIAlertAction(title: "OK", style: .default))
            }
            present(alert, animated: true)
        }
        
        // MARK: - UITextFieldDelegate
    @objc  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
