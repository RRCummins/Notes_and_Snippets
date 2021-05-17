//
//  StartViewController.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 4/15/21.
//

import UIKit
import CalendarKit

struct ItemDatas {
    var date: Date

}

class StartViewController: UIViewController {
    
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private var button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    var item = ItemDatas(date: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(didTapButton2), for: .touchUpInside)
        button3.addTarget(self, action: #selector(didTapButton3), for: .touchUpInside)
        
        button.setTitle("Launch FS Picker", for: .normal)
        button2.setTitle("Launch Top Cal Picker", for: .normal)
        button3.setTitle("Launch Scroll Top", for: .normal)
        label.text = dateFormatter.string(from: item.date)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        label.frame = CGRect(x: (view.frame.width / 2) - 150, y: (view.frame.height / 2), width: 300, height: 35)
        
        button.frame = CGRect(x: (view.frame.width / 2) - 150, y: (view.frame.height / 2) + 50, width: 300, height: 40)
        button2.frame = CGRect(x: (view.frame.width / 2) - 150, y: (view.frame.height / 2) + 100, width: 300, height: 40)
        button3.frame = CGRect(x: (view.frame.width / 2) - 150, y: (view.frame.height / 2) + 150, width: 300, height: 40)
        
    }
    
    @objc private func didTapButton() {
        print("Tapped Button")
        
        let calendarKitSample = FSViewController()
//        let pickerController = CalMonthViewController(
//            baseDate: item.date,
//            selectedDateChanged: { [weak self] date in
//                guard let self = self else { return }
//                print("Date Selected")
//                self.item.date = date
//                self.label.text = self.dateFormatter.string(from: date)
//            })
        present(calendarKitSample, animated: true, completion: nil)
    }
    
    @objc private func didTapButton2() {
        print("Tapped Button2")
        let vc = TopViewController()
        vc.title = "Top View"
        present(vc, animated: true, completion: nil)

    }
    
    @objc private func didTapButton3() {
        print("Tapped Button2")
        let vc = ScrollTopViewController()
        vc.title = "Top View"
        present(vc, animated: true, completion: nil)

    }
}
