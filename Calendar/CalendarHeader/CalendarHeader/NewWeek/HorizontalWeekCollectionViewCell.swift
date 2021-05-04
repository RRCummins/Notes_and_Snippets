//
//  HorizontalWeekCollectionViewCell.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 4/27/21.
//

import UIKit

class HorizontalWeekCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HorizontalWeekCollectionViewCell"
    
    // MARK: - Views
    private let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let weekdayLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let highlightedBackground: UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear
        return bg
    }()
    
    // MARK: - Properties
    private var isWeekDayLabel: Bool = false
    private var isDateLabel: Bool = false
    private var isSelectedDay: Bool = false
    private var highlightColor: UIColor = .systemRed
    private var highlightedTextColor: UIColor = .systemRed
    
    // MARK - init
    override init(frame: CGRect) {
        super.init(frame: .zero)

        addSubviews(dateLabel, weekdayLabel, highlightedBackground)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isWeekDayLabel = false
        isDateLabel = false
        isSelectedDay = false
    }
    
    func setSelectedDay() {
        if !isWeekDayLabel && isDateLabel {
            highlightedBackground.backgroundColor = highlightColor
        }
    }
    
    func configure(withDate date: Int, isSelectedDay: Bool) {
        isWeekDayLabel = false
        isDateLabel = true
        
        dateLabel.text = String(date)
        
    }
    
    func configure(withLabel label: String) {
        isDateLabel = false
        isWeekDayLabel = true
        
        weekdayLabel.text = label
    }
    
}
