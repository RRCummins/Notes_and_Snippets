//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Ryan Cummins on 10/3/21.
//

import AVFoundation
import Foundation
import UIKit

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter {
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    private var playerVC: PlayerViewController?
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let player = self.playerQueue, !tracks.isEmpty {
//            let item = player.currentItem
//            let items = player.items()
//            guard let index = items.firstIndex(where: { $0 == item }) else {
//                return nil
//            }
            return tracks[index]
        }
        return nil
    }
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    func startPlayback(from viewController: UIViewController,
                              track: AudioTrack
    ) {
        guard let url = URL(string: track.preview_url ?? "") else { return }
        player = AVPlayer(url: url)
        player?.volume = 0.3
        self.tracks = []
        self.track = track
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delagate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
//            self?.player?.pause()
            self?.playerQueue?.pause()
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(from viewController: UIViewController,
                              tracks: [AudioTrack]
    ) {

        self.tracks = tracks
        self.track = nil
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else {
                return nil
            }
            return AVPlayerItem(url: url)
        }))
        self.playerQueue?.volume = 0.5
//        self.playerQueue?.play()
        let vc = PlayerViewController()
        vc.title = "Queue"
        vc.dataSource = self
        vc.delagate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.pause()
//            self?.playerQueue?.pause()
            self?.playerQueue?.play()
        }
        self.playerVC = vc
    }
    
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
}


extension PlaybackPresenter: PlayerViewControllerDelagate {
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                self.playerQueue?.pause()
                player.pause()
            } else if player.timeControlStatus == .paused {
                self.playerQueue?.pause()
                player.play()
            }
        } else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                self.player?.pause()
                player.pause()
            } else if player.timeControlStatus == .paused {
                self.player?.pause()
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            //Not playing a playlist or album
            player?.pause()
            self.playerQueue?.pause()
        } else if let player = playerQueue {
            player.advanceToNextItem()
            index += 1
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackward() {

        if tracks.isEmpty {
            //Not playing a playlist or album
            player?.pause()
            playerQueue?.pause()
            player?.play()
        } else if let listItems = playerQueue?.items() {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: listItems)
            playerQueue?.play()
            playerQueue?.volume = 0.5
        }
    }
    
    
}
