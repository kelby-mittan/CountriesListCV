//
//  ViewController.swift
//  ConcurrencyLab
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var countryArr = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
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
    
    
}

extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryCellTableViewCell else {
            fatalError()
        }
        
        let country = countryArr[indexPath.row]
        
        cell.configureCell(for: country)
        
        return cell
    }
    
    
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

