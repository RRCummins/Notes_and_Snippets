//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Ryan Cummins on 10/12/21.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
