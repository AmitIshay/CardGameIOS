//
//  ViewController.swift
//  CardGame
//
//  Created by Student22 on 08/07/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var wel_text: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    let nameKey = "savedName"
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedName()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedName()
    }

    func loadSavedName() {
        if let savedName = UserDefaults.standard.string(forKey: nameKey) {
            if !savedName.isEmpty {
                nameTextField.isHidden = true
                wel_text.text = "Hello, \(savedName)!"
            } else {
                nameTextField.isHidden = false
                wel_text.text = "Enter your name"
            }
        } else {
            nameTextField.isHidden = false
            wel_text.text = "Enter your name"
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let newName = nameTextField.text, !newName.isEmpty {
            UserDefaults.standard.set(newName, forKey: nameKey)
            nameTextField.isHidden = true
            wel_text.text = "Hello, \(newName)!"
        }
                
                nameTextField.resignFirstResponder()    }
}

