//
//  SearchResult.swift
//  Spotify
//
//  Created by Ryan Cummins on 10/1/21.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
