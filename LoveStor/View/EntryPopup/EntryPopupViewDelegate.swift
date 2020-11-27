//
//  EntryPopupViewDelegate.swift
//  LoveStor
//
//  Created by ****** ****** on 27.11.2020.
//

import Foundation

enum ConditionsType {
    case termsOfCervice
    case privacyPolicy
}

protocol EntryPopupViewDelegate: class {
    func pushTermsViewController(conditionsType: ConditionsType)
    func pushNameViewController()
}
