//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Ryan Cummins on 3/6/21.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}

