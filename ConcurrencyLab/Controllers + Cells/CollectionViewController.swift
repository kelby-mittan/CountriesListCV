//
//  CollectionViewController.swift
//  ConcurrencyLab
//
//  Created by Kelby Mittan on 1/15/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var countryArr = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            if !searchQuery.isEmpty {
                countryArr = countryArr.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
                //                flagArr = FlagImage.getFlags().filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        loadCountries()
    }
    
    func loadCountries() {
        CountryAPIClient.getCountries { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let countries):
                print(countries.count)
                self.countryArr = countries
            }
        }
    }
    
    //        public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    //
    ////            let countrySelected = countryArr[indexPath.item]
    ////            guard let countryVC = segue.destination as? CountryDetailController else {
    ////                fatalError("could not load")
    ////            }
    //            guard let detailController = storyboard?.instantiateViewController(identifier: "CountryDetailController") as? CountryDetailController else {
    //              fatalError("could not downcast to CountryDetailController")
    //            }
    //            let country = countryArr[indexPath.item]
    //            detailController.country = country
    //            navigationController?.pushViewController(detailController, animated: true)
    //            print("hello")
    //
    //        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let cell = sender as? UICollectionViewCell, let countryVC = segue.destination as? CountryDetailController, let indexPath = collectionView.indexPath(for: cell) else {
            fatalError("could not load")
        }
        
        countryVC.country = countryArr[indexPath.row]
    }
    
    
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell else {
            fatalError("could not downcast country")
        }
        let country = countryArr[indexPath.row]
        cell.configureCell(for: country)
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 4   // space between items
        let maxWidth = UIScreen.main.bounds.size.width  // device's width
        let numberOfItems: CGFloat = 2
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
//        return CGSize(width: itemWidth, height: (itemWidth * 2))
        return CGSize(width: 180, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}


extension CollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        searchQuery = searchText
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            loadCountries()
            return
        }
        
        searchQuery = searchText
    }
}
