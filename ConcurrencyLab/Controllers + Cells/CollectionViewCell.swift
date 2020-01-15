//
//  CollectionViewCell.swift
//  ConcurrencyLab
//
//  Created by Kelby Mittan on 1/15/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var populationLabel: UILabel!
    
    func configureCell(for country: Country) {

        countryLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = country.population.description
        
        ImageClient.fetchImage(for: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png") { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImage.image = image
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
}
