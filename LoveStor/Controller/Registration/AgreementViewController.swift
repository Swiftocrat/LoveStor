//
//  AgreementViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 26.11.2020.
//

import UIKit

class AgreementViewController: UIViewController {

    @IBOutlet weak var entryPopupView: EntryPopupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        entryPopupView.delegate = self
    }
}

extension AgreementViewController: EntryPopupViewDelegate {
    func pushTermsViewController(conditionsType: ConditionsType) {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TermsViewController") as TermsViewController
        if conditionsType == .privacyPolicy {
            vc.titleText = "Privacy Policy"
            vc.conditionsText = "Lorem ipsum"
        } else {
            vc.titleText = "Terms of Service"
            vc.conditionsText = "Lorem ipsum"
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushNameViewController() {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NameViewController") as NameViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
