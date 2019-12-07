//
//  Country.swift
//  ConcurrencyLab
//
//  Created by Kelby Mittan on 12/6/19.
//  Copyright © 2019 Kelby Mittan. All rights reserved.
//

import Foundation


struct Country: Decodable {
    let name: String
    let capital: String
    let population: Int
    let flag: String
    
}

struct FlagImage: Decodable {
    let flag: String
    let name: String
    let capital: String
    let population: Int
}

extension FlagImage {
    static func getFlags() -> [FlagImage] {
        var flags = [FlagImage]()
        guard let fileURL = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            fatalError("could not locate json file")
        }
                
        do {
            let data = try Data(contentsOf: fileURL)
            let flagsData = try JSONDecoder().decode([FlagImage].self, from: data)
            
            flags = flagsData
        } catch {
            fatalError("contents failed to load \(error)")
        }
        return flags
    }
}
