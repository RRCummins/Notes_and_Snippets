//
//  CalendarHeader.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 5/6/21.
//

import UIKit
import FSCalendar

class CalendarHeader: UIView {
    
    var name: String = "" {
        didSet {
            label.text = name
        }
    }

    private var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Test 2021"

        addSubviews(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        label.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                           label.heightAnchor.constraint(equalTo: heightAnchor),
                           label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    
    func configure(for title: String) {
        name = title
    }
    
}
