//
//  CountryCellTableViewCell.swift
//  ConcurrencyLab
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class CountryCellTableViewCell: UITableViewCell {
    
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flagImage.layer.cornerRadius = 10
    }
    
    
    func configureCell(for country: FlagImage) {

        countryLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = country.population.description
        
        ImageClient.fetchImage(for: country.flag) { [weak self] (result) in
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
