//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Ryan Cummins on 10/7/21.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlist, album
    }
    
    var state: State = .playlist
    
    weak var delegate: LibraryToggleViewDelegate?
    
    private let playlistsButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.label, for: .normal)
        btn.setTitle("Playlists", for: .normal)
        return btn
    }()
    private let albumsButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.label, for: .normal)
        btn.setTitle("Albums", for: .normal)
        return btn
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(playlistsButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
        
        playlistsButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playlistsButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumsButton.frame = CGRect(x: playlistsButton.right, y: 0, width: 100, height: 40)
        
        layoutIndicator()
    }
    
    private func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(
                x: 0,
                y: playlistsButton.bottom,
                width: 100,
                height: 3)
        case .album:
            indicatorView.frame = CGRect(
                x: playlistsButton.right,
                y: playlistsButton.bottom,
                width: 100,
                height: 3)
        }
    }
    
    @objc private func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        state = .album
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
