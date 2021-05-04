//
//  ScrollingWeekCalendar.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 4/16/21.
//

import Foundation
import UIKit

public let dateCellHeight: CGFloat = 35

//let fontSmall: CGFloat = 12
//let fontMedium: CGFloat = 14
//let fontLarge: CGFloat = 16

struct CalendarFont {
    static let fontSmall: CGFloat = 12
    static let fontMedium: CGFloat = 14
    static let fontLarge: CGFloat = 16
}

struct CalendarColor {
    
    public static var shared = CalendarColor()
    
    public static var selectedColor = UIColor.systemGreen
    public static var todayColor = UIColor.systemGreen
    public static var textDark = UIColor.darkText
    public static var textLight = UIColor.lightGray
    public static var dateColor = UIColor.darkGray
}

public class ScrollingWeekCalendar: UIView {
    
    public static var dateFormat = "EEEE, MMM d"
    
//    public static var selectedColor = UIColor.systemGreen
//    public static var todayColor = UIColor.systemGreen
//    public static var textDark = UIColor.darkText
//    public static var textLight = UIColor.lightGray
//    public static var dateColor = UIColor.darkGray
    
    let border = UIColor.lightGray
    
    // MARK: Views
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Friday, April 16th"
        label.font = .boldSystemFont(ofSize: CalendarFont.fontLarge)
        label.textColor = CalendarColor.dateColor
        return label
    }()
    
    private lazy var arrow: UIImageView = { [unowned self] in
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.down.app")
        image.tintColor = UIColor.darkText
        image.transform = CGAffineTransform(rotationAngle: .pi)
        return image
    }()
    
    private lazy var todayButton: UIButton = { [unowned self] in
        let button = UIButton(type: .system)
        button.setTitle("Go to Today", for: .normal)
        button.setTitleColor(CalendarColor.textDark, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CalendarFont.fontMedium)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        button.layer.cornerRadius = 5
        button.tintColor = .red
        button.layer.borderWidth = 1
        button.layer.borderColor = border.cgColor
        button.isHidden = true
        return button
    }()
    
    private lazy var weekDays: UIView = { [unowned self] in
        let stackView = UIStackView()
        stackView.addArrangedSubview(WeekDayLabel(with: "S", isDarkText: false))
        stackView.addArrangedSubview(WeekDayLabel(with: "M"))
        stackView.addArrangedSubview(WeekDayLabel(with: "T"))
        stackView.addArrangedSubview(WeekDayLabel(with: "W"))
        stackView.addArrangedSubview(WeekDayLabel(with: "T"))
        stackView.addArrangedSubview(WeekDayLabel(with: "F"))
        stackView.addArrangedSubview(WeekDayLabel(with: "S", isDarkText: false))
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.isHidden = true
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isDirectionalLockEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.isHidden = true
        return collectionView
    }()
    
    //MARK: - Properties
    private var firstTime = true
    private let createCellThreshold = 5
    private let calendar = Calendar.current
    private let today = Date()
    private var list = [Date]()
//    public var calendarFont = CalendarFont()
//    public var calendarColor = CalendarColor()
    
    private var currentIndex: Int {
        didSet {
            selectedDate = list[currentIndex].weekDates[selectedWeekDay]
        }
    }
    
    public var selectedWeekDay: Int
    public var selectedDate: Date {
        didSet {
            dateLabel.text = selectedDate.string(format: ScrollingWeekCalendar.dateFormat)
            todayButton.isHidden = selectedDate.isToday
            onSelectionChanged?(selectedDate)
        }
    }
    public var onSelectionChanged: ((Date) -> Void)?
    
    var collectionViewToBottom: NSLayoutConstraint!
    var dateViewToBottom: NSLayoutConstraint!
    
    
    //MARK: - Initializers
    public override init(frame: CGRect) {
        
        selectedWeekDay = today.dayOfTheWeek
        selectedDate = today
        currentIndex = createCellThreshold
        
        super.init(frame: frame)
                
        setupViews()
        
        list.append(today.startOfWeek)
        loadCells(after: today)
        loadCells(before: today)
        
        loadCalendar()
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.scrollToItem(at: IndexPath(row: self?.createCellThreshold ?? 5, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadCalendar() {
        let shouldShow = arrow.transform == CGAffineTransform.identity
//        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            collectionView.isHidden = shouldShow
            weekDays.isHidden = shouldShow
            arrow.transform = CGAffineTransform(rotationAngle: shouldShow ? .pi : 0)
            dateViewToBottom.isActive = shouldShow
            collectionViewToBottom.isActive = !shouldShow
//        })
    }
    
    func toggleCalendar() {
        // Uncomment for a collopsable calendar view
        let shouldShow = arrow.transform == CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.collectionView.isHidden = shouldShow
            self?.weekDays.isHidden = shouldShow
            self?.arrow.transform = CGAffineTransform(rotationAngle: shouldShow ? .pi : 0)
            self?.dateViewToBottom.isActive = shouldShow
            self?.collectionViewToBottom.isActive = !shouldShow
        })
    }
    
}


// MARK: - Setup Views
extension ScrollingWeekCalendar {
    private func setupViews() {
        
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateViewToBottom = dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            dateViewToBottom
        ])
        
        // Uncomment for a collopsable calendar view
//        arrow.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(arrow)
//        NSLayoutConstraint.activate([
//            arrow.widthAnchor.constraint(equalTo: dateLabel.heightAnchor),
//            arrow.heightAnchor.constraint(equalTo: dateLabel.heightAnchor),
//            arrow.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8),
//            arrow.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
//        ])
        
        // Uncomment for a collopsable calendar view
//        [dateLabel, arrow].forEach {
//            $0.addTapGestureRecognizer { [weak self] in
//                self?.toggleCalendar()
//            }
//        }
        
        
        todayButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(todayButton)
        NSLayoutConstraint.activate([
            todayButton.heightAnchor.constraint(equalToConstant: 25),
            todayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            todayButton.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
        ])
        
        todayButton.addTapGestureRecognizer { [weak self] in
            guard let startOfWeek = self?.today.startOfWeek,
                  let index = self?.list.firstIndex(of: startOfWeek),
                let dayOfWeek = self?.today.dayOfTheWeek else {
                return
            }
            
            self?.selectedWeekDay = dayOfWeek
            self?.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
            if self?.currentIndex == index {
                self?.collectionView.reloadData()
            }
        }
        
        weekDays.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weekDays)
        NSLayoutConstraint.activate([
            weekDays.heightAnchor.constraint(equalToConstant: 30),
            weekDays.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            weekDays.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            weekDays.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionViewToBottom = collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: dateCellHeight),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            collectionView.topAnchor.constraint(equalTo: weekDays.bottomAnchor)
        ])
    }
}

// MARK: - Collection View Delegates
extension ScrollingWeekCalendar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.reuseIdentifier, for: indexPath) as? DateCollectionViewCell else {
            fatalError("Unable to dequeue DateViewCell")
        }
        
        cell.onSelectionChanged = { [weak self] selectedIndex in
            self?.selectedWeekDay = selectedIndex
            self?.currentIndex = indexPath.row
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if firstTime {
            collectionView.scrollToItem(at: IndexPath(row: createCellThreshold, section: 0), at: .centeredHorizontally, animated: false)
            firstTime = false
            return
        }
        
        if indexPath.row < createCellThreshold, let date = list.first {
            loadCells(before: date)
        } else if list.count - indexPath.row < createCellThreshold, let date = list.last {
            loadCells(after: date)
        }
        
        guard let cell = cell as? DateCollectionViewCell else { return }
        let date = list[indexPath.row]
        cell.setup(with: date, selectedIndex: selectedWeekDay)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let index = collectionView.indexPathsForVisibleItems.first?.row else {
            return
        }
        currentIndex = index
    }
  
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.size.width - 16
        return CGSize(width: width, height: dateCellHeight)
    }
}

// MARK: - Infinite scroll
extension ScrollingWeekCalendar {
    private func loadCells(after: Date) {
        var date = after
        var tmpList = [Date]()
        for _ in 0..<createCellThreshold {
            date = date.startOfNextWeek
            tmpList.append(date)
        }
        list += tmpList
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    private func loadCells(before: Date) {
        var date = before
        var tmpList = [Date]()
        for _ in 0..<createCellThreshold {
            date = date.startOfPreviousWeek
            tmpList.append(date)
        }
        list = tmpList.reversed() + list
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self, let index = strongSelf.collectionView.indexPathsForVisibleItems.first?.row else {
                    return
            }
            
            let indexPath = IndexPath(row: index + strongSelf.createCellThreshold + 1, section: 0)
            strongSelf.collectionView.reloadData()
            strongSelf.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}
