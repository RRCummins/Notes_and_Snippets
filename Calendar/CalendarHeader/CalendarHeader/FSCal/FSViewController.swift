//
//  ViewController.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 5/6/21.
//

import UIKit
import FSCalendar

class FSViewController: UIViewController {
    
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var header: CalendarHeader!
    
    private var displayMonth: String = "" {
        willSet {
            header.configure(for: newValue)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupCalendar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let constraints = [calendar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
                           calendar.widthAnchor.constraint(equalTo: view.widthAnchor),
                           calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                           
        ]
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupCalendar() {
        let calendar = FSCalendar(frame: .zero)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scrollDirection = .horizontal
        calendar.clipsToBounds = true
        calendar.scope = .week
        calendar.calendarHeaderView = FSCalendarHeaderView()
        calendar.headerHeight = 50
        
        let header = CalendarHeader()
        header.configure(for: "Puppers 2021")
        calendar.addSubviews(header)
        self.header = header
      
        
        view.addSubview(calendar)
        self.calendar = calendar
        
        header.translatesAutoresizingMaskIntoConstraints = false
        let headerConstraints = [header.topAnchor.constraint(equalTo: calendar.topAnchor),
                                 header.leadingAnchor.constraint(equalTo: calendar.leadingAnchor),
                                 header.trailingAnchor.constraint(equalTo: calendar.trailingAnchor),
                                 header .heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(headerConstraints)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnMonth))
        header.addGestureRecognizer(tap)
        
        let monthToDisplay = monthString(date: calendar.currentPage)
        displayMonth = monthToDisplay
    }
    
    
    @objc private func tapOnMonth() {
        print("Scroll back to Today", #fileID, #function, #line)
        scrollToToday()
    }
    
    /// Scrolls the calendar to the page with the current date
    func scrollToToday() {
        calendar.setCurrentPage(Date(), animated: true)
        
    }
    
    /// Returns a String with the "Month Year"
    func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: date)
    }


}

extension FSViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected date is \(date) at month position \(monthPosition)", #fileID, #function, #line)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        let monthToDisplay = monthString(date: calendar.currentPage)
        displayMonth = monthToDisplay
        
        print("Current Week changed to \(monthToDisplay)", #fileID, #function, #line)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
//        dateFormatter.locale = Locale.init(identifier: "fa_IR")

        for dateStr in dateData{
            if(dateFormatter.string(from: date) == dateStr)
            {
                print("Found One!!!")
                return 1
            }
        }
        return 0
    }
    
}

var dateData = ["2021/05/06",
             "2021/05/02",
             "2021/04/26",
             "2021/04/16",
             "2021/05/16",
             "2021/05/12",
             "2021/05/14",
             "2021/05/29",
             "2021/06/06",
]

