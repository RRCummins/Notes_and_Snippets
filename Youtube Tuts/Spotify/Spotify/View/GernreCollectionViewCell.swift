//
//  GernreCollectionViewCell.swift
//  Spotify
//
//  Created by Ryan Cummins on 9/28/21.
//

import UIKit

class GernreCollectionViewCell: UICollectionViewCell {
    static let identifier = "GernreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        iv.image = UIImage(systemName: "music.quarternote.3",
                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return iv
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink, .systemPurple,
        .systemGreen, .systemOrange,
        .systemBlue, .systemTeal,
        .systemRed, .systemYellow,
        .darkGray, .systemMint,
        .systemCyan
    ]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let constraints = [
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
//            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            label.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
        ]
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with title: String) {
        label.text = title
        contentView.backgroundColor = colors.randomElement()
    }
}
