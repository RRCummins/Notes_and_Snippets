//
//  WeekDayLabel.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 4/16/21.
//

import UIKit

class WeekDayLabel: UIView {
    
    // MARK: - Views
    
    private var label: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private var selectedLabelShape: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = dateCellHeight / 2
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private var indicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = dateCellHeight / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - Properties
    private var isDark: Bool
    var isSelected: Bool = false {
        didSet {
            label.backgroundColor = isSelected ? CalendarColor.selectedColor : .clear
            updateTextColor()
        }
    }
    var hasIndicator: Bool = false {
        didSet {
            indicator.backgroundColor = hasIndicator ? .systemRed : .clear
        }
    }
    // Usually used for current day text color
    var isTextHighlighted: Bool = false {
        didSet {
            updateTextColor()
        }
    }
    
    // MARK: - Init
    init(with text: String, isDarkText: Bool = true) {
        self.isDark = isDarkText
        super.init(frame: .zero)
        
        label.textColor = isDarkText ? CalendarColor.textDark : CalendarColor.textDark
        label.text = text
        
        setupViews()
    }
    
    // MARK: - Functions
    private func setupViews() {
        addSubviews(selectedLabelShape, indicator, label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: dateCellHeight),
            label.heightAnchor.constraint(equalToConstant: dateCellHeight)
        ])
    }
    
    //MARK: - Cell Text Color/Font
    private func updateTextColor() {
        if isSelected {
            label.textColor = .white
            label.font = .systemFont(ofSize: 11, weight: .bold)
        } else if isTextHighlighted {
            label.textColor = CalendarColor.todayColor
        } else if isDark {
            label.textColor = CalendarColor.textDark
        } else {
            label.textColor = CalendarColor.textLight
        }
    }
    
    func set(text: String) {
        label.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
