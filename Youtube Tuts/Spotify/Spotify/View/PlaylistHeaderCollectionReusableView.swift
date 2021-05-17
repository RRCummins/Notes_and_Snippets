//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Ryan Cummins on 5/15/21.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
//        label.clipsToBounds = false
        return label
    }()
    
    private let playlistImageVew: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "photo")
        
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.5
        iv.layer.shadowOffset = .zero
        iv.layer.shadowRadius = 10
        
        return iv
    }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(
                            systemName: "play.fill",
                            withConfiguration: UIImage.SymbolConfiguration(
                                pointSize: 32,
                                weight: .regular)),
                        for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        
        return button
    }()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(playlistImageVew)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(playAllButton)
        
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapPlayAll() {
//        print("didTapPlayAll", #fileID, #function, #line)
        delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let constraints = [
            playlistImageVew.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            playlistImageVew.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.76),
            playlistImageVew.widthAnchor.constraint(equalTo: playlistImageVew.heightAnchor),
            playlistImageVew.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: playlistImageVew.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: playlistImageVew.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: playlistImageVew.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: playlistImageVew.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: playAllButton.leadingAnchor, constant: -8),
            
            ownerLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            ownerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            ownerLabel.trailingAnchor.constraint(equalTo: playAllButton.leadingAnchor, constant: -8),
            ownerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            playAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            playAllButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            playAllButton.widthAnchor.constraint(equalToConstant: 50),
            playAllButton.heightAnchor.constraint(equalTo: playAllButton.widthAnchor),
        ]
        
        playlistImageVew.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ownerLabel.translatesAutoresizingMaskIntoConstraints = false
        playAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        playAllButton.layer.cornerRadius = playAllButton.width / 2
        playAllButton.layer.shadowColor = UIColor.black.cgColor
        playAllButton.layer.shadowOpacity = 0.5
        playAllButton.layer.shadowOffset = .zero
        playAllButton.layer.shadowRadius = 10
        
        NSLayoutConstraint.activate(constraints)
    }
    
    public func configure(with viewModel: PlaylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.description
        playlistImageVew.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
