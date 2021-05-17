//
//  CustomDayCell.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 5/5/21.
//

import UIKit

class CustomDayCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(origin: .zero, size: frame.size)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
