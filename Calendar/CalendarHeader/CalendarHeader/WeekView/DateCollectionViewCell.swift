//
//  DateCollectionViewCell.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 4/16/21.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    // MARK: - Static
    static let reuseIdentifier = "DateCollectionViewCell"
    
    // MARK: - Views
    private var sevenDaysView: UIView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(WeekDayLabel(with: "WD1", isDarkText: false))
        stackView.addArrangedSubview(WeekDayLabel(with: "WD2"))
        stackView.addArrangedSubview(WeekDayLabel(with: "WD3"))
        stackView.addArrangedSubview(WeekDayLabel(with: "WD4"))
        stackView.addArrangedSubview(WeekDayLabel(with: "WD5"))
        stackView.addArrangedSubview(WeekDayLabel(with: "WD6"))
        stackView.addArrangedSubview(WeekDayLabel(with: "WD7", isDarkText: false))
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Properties
    private var dates = [Date]()
    var onSelectionChanged: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(sevenDaysView)
        sevenDaysView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sevenDaysView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sevenDaysView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sevenDaysView.topAnchor.constraint(equalTo: topAnchor),
            sevenDaysView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        for (index, date) in sevenDaysView.subviews.enumerated() {
            date.addTapGestureRecognizer { [weak self] in
                self?.select(at: index)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        for (index, (view, date)) in zip(sevenDaysView.subviews, dates).enumerated() {
//            guard let dayLabel = view as? WeekDayLabel else { continue }
//
////            dayLabel.set(text: "\(date.day)")
////            dayLabel.isTextHighlighted = dates[index].isToday
//            dayLabel.isSelected = index == selectedIndex
        
    }
    
    func select(at selectedIndex: Int) {
        for (index, date) in sevenDaysView.subviews.enumerated() {
            print("The Index selected is \(index) and teh date is \(date)", #fileID, #function, #line)
            guard let dayLabel = date as? WeekDayLabel else { return }
            dayLabel.isTextHighlighted = dates[index].isToday
            dayLabel.isSelected = index == selectedIndex
        }
        onSelectionChanged?(selectedIndex)
    }
    
    func setup(with startDate: Date, selectedIndex: Int) {
        dates = startDate.weekDates
        
        for (index, (view, date)) in zip(sevenDaysView.subviews, dates).enumerated() {
            guard let dayLabel = view as? WeekDayLabel else { continue }
            
            dayLabel.set(text: "\(date.day)")
            dayLabel.isTextHighlighted = dates[index].isToday
            dayLabel.isSelected = index == selectedIndex
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
