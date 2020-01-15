//
//  CountryDetailController.swift
//  ConcurrencyLab
//
//  Created by Kelby Mittan on 12/7/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class CountryDetailController: UIViewController {

    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        guard let validCountry = country else {
            fatalError("could not load country")
        }
        
        nameLabel.text = validCountry.name
        capitalLabel.text = "Capital: \(validCountry.capital)"
        populationLabel.text = "Population: \(validCountry.population.description)"
        
        ImageClient.fetchImage(for: "https://www.countryflags.io/\(validCountry.alpha2Code)/flat/64.png") { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImage.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

}
