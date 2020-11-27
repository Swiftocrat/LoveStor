//
//  NameViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 26.11.2020.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameTextFieldBackgroundImageView: UIImageView!
    @IBOutlet weak var confirmButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        guard let text = nameTextField.text else { return }
        defaults.setValue(text, forKey: "enteredName")
    }
}
