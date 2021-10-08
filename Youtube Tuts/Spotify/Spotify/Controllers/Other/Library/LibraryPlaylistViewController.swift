//
//  LibraryPlaylistViewController.swift
//  Spotify
//
//  Created by Ryan Cummins on 10/7/21.
//

import UIKit

class LibraryPlaylistViewController: UIViewController {
    
    private var playlists: [Playlist] = []
    
    private let noPlaylistsView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self,
                           forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setUpNoPlaylistsView()
        
        fetchPlaylists()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
        tableView.frame = view.bounds
    }
    private func fetchPlaylists() {
        DispatchQueue.main.async {
            APICaller.shared.getCurrentUserPlaylists { [weak self] result in
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setUpNoPlaylistsView() {
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        noPlaylistsView.configure(with: ActionLabelViewViewModel(
            text: "You don't have any PLaylists yet",
            actionTitle: "Create"))
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            // Show Label
            DispatchQueue.main.async {
//                self.tableView.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.tableView.isHidden = true
                    self.noPlaylistsView.isHidden = false
                }
            }
        } else {
            // Show Table
            DispatchQueue.main.async {
                self.tableView.reloadData()
//                self.noPlaylistsView.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    self.noPlaylistsView.isHidden = true
                    self.tableView.isHidden = false
                }
            }
        }
    }
    
    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "New Playlists",
                                      message: "Enter playlist name",
                                      preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Playlist..."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                      return
                  }
            
            APICaller.shared.createPlaylist(with: text) { [weak self] success in
                if success {
                    // Refresh list of playlists
                    self?.fetchPlaylists()
                } else {
                    print("Failed to create playlist", #fileID, #function, #line)
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    
}

extension LibraryPlaylistViewController: ActionLabelViewDelegate {
    func actionLabelViewDelegate(_ actionView: ActionLabelView) {
        // Show Creation UI
        showCreatePlaylistAlert()
    }
}

extension LibraryPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else { return UITableViewCell() }
        
        let playlist = playlists[indexPath.row]
        
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
            title: playlist.name,
            subtitle: playlist.owner.display_name,
            url: URL(string: playlist.images.first?.url ?? "")))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
