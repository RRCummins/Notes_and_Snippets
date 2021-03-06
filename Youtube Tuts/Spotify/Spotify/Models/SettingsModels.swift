//
//  SettingsModels.swift
//  Spotify
//
//  Created by Ryan Cummins on 2/27/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void // Handler is a function that takes in nothing and returns nothing
}
