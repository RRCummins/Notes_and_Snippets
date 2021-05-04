//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Ryan Cummins on 3/7/21.
//

import UIKit
import SDWebImage


class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let constraints = [
            playlistCoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.65),
            playlistCoverImageView.widthAnchor.constraint(equalTo: playlistCoverImageView.heightAnchor),
            playlistCoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playlistCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            playlistNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playlistNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 24),
            playlistNameLabel.topAnchor.constraint(equalTo: playlistCoverImageView.bottomAnchor, constant: 8),
            
            creatorNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            creatorNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 24),
            creatorNameLabel.topAnchor.constraint(equalTo: playlistNameLabel.bottomAnchor, constant: 8),
            
        ]
        playlistCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        playlistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    public func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artwork, completed: nil)
    }
    
}
