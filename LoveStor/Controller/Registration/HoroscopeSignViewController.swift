//
//  HoroscopeSignViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 26.11.2020.
//

import UIKit

class HoroscopeSignViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let horoscopeSignsImagesArray = [UIImage(named: "Virgo"), UIImage(named: "Cancer"), UIImage(named: "Aquarius"), UIImage(named: "Gemini"), UIImage(named: "Capricorn"), UIImage(named: "Taurus"), UIImage(named: "Leo"), UIImage(named: "Aries"), UIImage(named: "Scorpio"), UIImage(named: "Sagittarius"), UIImage(named: "Pisces"), UIImage(named: "Pisces")]
    let horoscopeSignsNamesArray = ["Virgo", "Cancer", "Aquarius", "Gemini", "Capricorn", "Taurus", "Leo", "Aries", "Scorpio", "Sagittarius", "Pisces", "Libra"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "HoroscopeSignTableViewCell", bundle: nil), forCellReuseIdentifier: "horoscopeSignCell")
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
}

extension HoroscopeSignViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horoscopeSignsImagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "horoscopeSignCell", for: indexPath) as! HoroscopeSignTableViewCell
        cell.signImageView.image = horoscopeSignsImagesArray[indexPath.row]
        cell.horoscopeSignNameLabel.text = horoscopeSignsNamesArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "horoscopeSignCell", for: indexPath) as! HoroscopeSignTableViewCell
        
//        cell.contentView.layer.opacity = 0.1
//        cell.showSelection()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

            let cellToDeSelect = tableView.dequeueReusableCell(withIdentifier: "horoscopeSignCell", for: indexPath) as! HoroscopeSignTableViewCell
            cellToDeSelect.contentView.backgroundColor = .clear
        }
}
