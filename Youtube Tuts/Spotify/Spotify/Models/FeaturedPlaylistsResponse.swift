//
//  FeaturedPlaylistResponse.swift
//  Spotify
//
//  Created by Ryan Cummins on 3/5/21.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistRepsonse
}

struct PlaylistRepsonse: Codable {
    let items: [Playlist]
}

