//
//  AvatarSelectionViewController.swift
//  LoveStor
//
//  Created by ****** ****** on 26.11.2020.
//

import UIKit

class AvatarSelectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let iconsArray = [UIImage(named: "avatar1"), UIImage(named: "avatar2"), UIImage(named: "avatar3"), UIImage(named: "avatar4"), UIImage(named: "avatar5"), UIImage(named: "avatar6"), UIImage(named: "avatar7"), UIImage(named: "avatar8"), UIImage(named: "avatar9"), UIImage(named: "avatar10"), UIImage(named: "avatar11"), UIImage(named: "avatar12")]
    let iconsNamesArray = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5", "avatar6",  "avatar7", "avatar8", "avatar9", "avatar10", "avatar11", "avatar12"]
    var selectedIndex: Int?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: "ProfileIconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "profileIconCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 110, height: 110)
        collectionView.collectionViewLayout = layout
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let selectedIndex = selectedIndex else { return }
        defaults.setValue(iconsNamesArray[selectedIndex], forKey: "selectedIcon")
    }
}

extension AvatarSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileIconCell", for: indexPath) as! ProfileIconCollectionViewCell
        cell.avatarImageView.image = iconsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}
