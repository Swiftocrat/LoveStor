//
//  ProfileViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 27.11.2020.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var instructionLabelTopConstraint: NSLayoutConstraint!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelectedValues()
        if UIScreen.main.bounds.height < 668.0 {
            instructionLabelTopConstraint.constant = 30
        }
    }
    
    func setupSelectedValues() {
        let selectedAvatarName = defaults.value(forKey: "selectedIcon")
        let enteredName = defaults.value(forKey: "enteredName")
        avatarImageView.image = UIImage(named: selectedAvatarName as! String)
        nameTextField.text = enteredName as? String
    }
}
