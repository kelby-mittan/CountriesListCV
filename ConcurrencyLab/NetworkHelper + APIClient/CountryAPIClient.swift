//
//  CountryAPIClient.swift
//  ConcurrencyLab
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation

struct CountryAPIClient {
    
    static func getCountries(completion: @escaping (Result<[Country], AppError>) -> ()) {
        
        let url = "https://restcountries.eu/rest/v2/name/united"
        
        NetworkHelper.shared.performDataTask(with: url) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch {
                    print(error)
                }
            }
        }
    }
    
}
