//
//  SettingsTableViewCell.swift
//  SettingsExample
//
//  Created by Ryan Cummins on 12/9/20.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    private let iconCantainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier
        )
        
        contentView.addSubview(label)
        contentView.addSubview(iconCantainer)
        iconCantainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height - 12
        iconCantainer.frame = CGRect(x: 15,
                                     y: 6,
                                     width: size,
                                     height: size)
        
        let imageSize = size/1.5
        iconImageView.frame = CGRect(x: (size - imageSize)/2, y: (size - imageSize)/2, width: imageSize, height: imageSize)
        
        label.frame = CGRect(x: 25 + iconCantainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width - 20 - iconCantainer.frame.size.width - 10,
                             height: contentView.frame.size.height)
    }
    
    // This resets the properties so the view can be reused
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconCantainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconCantainer.backgroundColor = model.iconBackgroundColor
    }
}
