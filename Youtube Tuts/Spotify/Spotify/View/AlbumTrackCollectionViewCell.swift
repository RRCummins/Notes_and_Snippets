//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Ryan Cummins on 9/27/21.
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
    
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
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let constraints = [ trackNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                            trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                            trackNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
                            
                            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4),
                            artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
                
        ]
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    public func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
    
}
