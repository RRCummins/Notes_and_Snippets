//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by Ryan Cummins on 10/7/21.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {
    
    private var albums: [Album] = []
    
//    public var selectionHandler: ((Playlist) -> Void)?
    
    private let noAlbumsView = ActionLabelView()
    
    private var observer: NSObjectProtocol?
    
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
        setUpNoAlbumsView()
        observer = NotificationCenter.default.addObserver(
            forName: .albumSavedNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.fetchData()
            })
        
        
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noAlbumsView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    private func fetchData() {
        albums.removeAll()
        DispatchQueue.main.async {
            APICaller.shared.getCurrentUserAlbums { [weak self] result in
                switch result {
                case .success(let albums):
                    self?.albums = albums
                    self?.updateUI()
                case .failure(let error):
                    self?.updateUI()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func setUpNoAlbumsView() {
        view.addSubview(noAlbumsView)
        noAlbumsView.delegate = self
        noAlbumsView.configure(with: ActionLabelViewViewModel(
            text: "You don't have any save Albums yet",
            actionTitle: "Browse"))
    }
    
    private func updateUI() {
        if albums.isEmpty {
            // Show Label
            DispatchQueue.main.async {
//                self.tableView.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.tableView.isHidden = true
                    self.noAlbumsView.isHidden = false
                }
            }
        } else {
            // Show Table
            DispatchQueue.main.async {
                self.tableView.reloadData()
//                self.noPlaylistsView.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    self.noAlbumsView.isHidden = true
                    self.tableView.isHidden = false
                }
            }
        }
    }
    
    
}

extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    func actionLabelViewDelegate(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else { return UITableViewCell() }
        
        let album = albums[indexPath.row]
        
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
            title: album.name,
            subtitle: album.artists.first?.name ?? "",
            url: URL(string: album.images.first?.url ?? "")))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let album = albums[indexPath.row]

        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
//        vc.isOwner = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
