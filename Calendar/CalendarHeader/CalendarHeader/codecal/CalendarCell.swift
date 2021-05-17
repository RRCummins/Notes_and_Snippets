//
//  CalendarCell.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 5/6/21.
//

import UIKit

class CalendarCVCell: UICollectionViewCell {
    
    let identifier = "CalendarCVCell"
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var dayOfMonth: String = "" {
        didSet {
            label.text = dayOfMonth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(label)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let constraints = [
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            label.widthAnchor.constraint(equalTo: label.heightAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        ]
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayOfMonth = ""
        label.text = ""
        
    }
    
    public func configure(with date: String) {
        dayOfMonth = date
        label.text = date
    }
    
    
    
}
