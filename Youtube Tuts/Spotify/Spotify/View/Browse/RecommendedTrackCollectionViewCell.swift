//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Ryan Cummins on 3/7/21.
//

import UIKit
import SDWebImage


class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let constraints = [ albumCoverImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
                            albumCoverImageView.heightAnchor.constraint(equalTo: albumCoverImageView.widthAnchor),
                            albumCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                            albumCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                            
                            trackNameLabel.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 8),
                            trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                            trackNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
                            
                            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),
                            artistNameLabel.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 8),
                            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
                
        ]
        
        albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    public func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
}
