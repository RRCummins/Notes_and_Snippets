//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Ryan Cummins on 5/4/21.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ -> NSCollectionLayoutSection? in
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(1.0)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
                
                // Group
                
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(60)
                    ),
                    subitem: item,
                    count: 1)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.4)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                ]
                return section
            }))


    private var viewModels = [AlbumCollectionViewCellViewModel]()
    
    private var tracks = [AudioTrack]()
    private let album: Album
    
    init(album: Album) {
        self.album = album
        
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = album.name
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(RecommendedTrackCollectionViewCell.self,
                                forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.register(AlbumTrackCollectionViewCell.self,
                                forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.identifier)
        collectionView.register(PlaylistHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        
        APICaller.shared.getAlbumDetails(for: album) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
//                    RecommendedAlbumCollectionViewCell
                    self?.tracks = model.tracks.items
                    self?.viewModels = model.tracks.items.compactMap({
                        AlbumCollectionViewCellViewModel(
                            name: $0.name,
                            artistName: $0.artists.first?.name ?? "-",
                            artworkURL: URL(string: $0.album?.images.first?.url ?? ""))
                    })
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription, #fileID, #function, #line)
                } // switch
            } // dispatchQueue
        } // caller.getAlbumDetails completion
    } // VDL
    

override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
}
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {

func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModels.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: AlbumTrackCollectionViewCell.identifier,
        for: indexPath
    ) as? AlbumTrackCollectionViewCell else {
        return UICollectionViewCell()
    }
    cell.backgroundColor = .red
    cell.configure(with: viewModels[indexPath.row])
    return cell
}

func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier,
        for: indexPath
    ) as? PlaylistHeaderCollectionReusableView,
    kind == UICollectionView.elementKindSectionHeader else {
        return UICollectionReusableView()
    }
    let headerViewModel = PlaylistHeaderViewViewModel(
        name: album.name,
        ownerName: album.artists.first?.name,
        description: "Release Date: \(String.formatterdDate(string: album.release_date))",
        artworkURL: URL(string: album.images.first?.url ?? ""))
    header.configure(with: headerViewModel)
    header.delegate = self
    return header
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    print("Play a dong here", #fileID, #function, #line)
    let track = tracks[indexPath.row]
    PlaybackPresenter.startPlayback(from: self, track: track)
}


}

extension AlbumViewController: PlaylistHeaderCollectionReusableViewDelegate {
func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
    print("Play All in Album!", #fileID, #function, #line)
    PlaybackPresenter.startPlayback(from: self, tracks: tracks)
}


}
