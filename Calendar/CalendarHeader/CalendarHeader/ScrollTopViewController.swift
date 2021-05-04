//
//  ScrollTopViewController.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 4/16/21.
//

import UIKit

class ScrollTopViewController: UIViewController {
    
    let calendarView: ScrollingWeekCalendar = {
        let calendar = ScrollingWeekCalendar()
        return calendar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(calendarView)
        
//        calendarView.dateFormat = "EEEE, MMM d"
//        calendarView.selectedColor = .red
//        calendarView.todayColor = .systemTeal
//        calendarView.textDark = .black
//        calendarView.textLight = .gray
//        calendarView.dateColor = .black
        
        // Add paginated delegates only
        calendarView.onSelectionChanged = { date in
              print(date)
          }
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendarView.leftAnchor.constraint(equalTo: view.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        calendarView.backgroundColor = UIColor(named: "#f7f7f7")
        
        calendarView.onSelectionChanged = { date in
            print(date)
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        calendarView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: view.frame.width,
                                    height: view.frame.height / 3)
    }
    


}
