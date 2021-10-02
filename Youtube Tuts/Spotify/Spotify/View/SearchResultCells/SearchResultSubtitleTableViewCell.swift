//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Ryan Cummins on 10/1/21.
//

import UIKit
import SDWebImage

class SearchResultSubtitleTableViewCell: UITableViewCell {
    static let identifier = "SearchResultSubtitleTableViewCell"
    
    private let title: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitle: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier:  String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height-5
        iconImageView.frame = CGRect(
            x: 10,
            y: 2,
            width: imageSize,
            height: imageSize)
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
        
        let labelHeight = contentView.height/2
        title.frame = CGRect(
            x: iconImageView.right+10,
            y: 0,
            width: contentView.width-iconImageView.right-15,
            height: labelHeight)
        
        subtitle.frame = CGRect(
            x: iconImageView.right+10,
            y: title.bottom,
            width: contentView.width-iconImageView.right-15,
            height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        title.text = nil
        subtitle.text = nil
    }
    
    public func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        title.text = viewModel.title
        subtitle.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.url, completed: nil)
    }
    
}
