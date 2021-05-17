//
//  CodeCalViewController.swift
//  CalendarHeader
//
//  Created by Ryan Cummins on 5/5/21.
//

import UIKit

class CodeCalViewController: UIViewController {
    private var monthLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            return CodeCalViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
    private let stackView: UIStackView = {
        
        let label1 = UILabel()
        label1.text = "S"
        let label2 = UILabel()
        label2.text = "M"
        let label3 = UILabel()
        label3.text = "T"
        let label4 = UILabel()
        label4.text = "W"
        let label5 = UILabel()
        label5.text = "F"

        let sv = UIStackView(arrangedSubviews: [label1, label2, label3, label4, label3, label5, label1])
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    var selectedDate = Date()
    var totalSquares: [Date] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(monthLabel)
        view.addSubview(stackView)
        configureCollectionView()
        
        
        view.backgroundColor = .systemBackground
        setCellsView()
        setWeekView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let constraints = [stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
                           stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
                           stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                           stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                           
                           collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
                           collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
                           collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
                           collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        collectionView.frame = CGRect(x: 0, y: 40, width: view.frame.width, height: (view.frame.height / 3))
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CalendarCVCell.self,
                                forCellWithReuseIdentifier: CalendarCVCell.identifier)

    }
    
    func setCellsView() {
//        collectionView.frame = CGRect(x: 0, y: 40, width: view.frame.width, height: (view.frame.height / 3))
//        let width = (collectionView.frame.size.width - 2) / 8
//        let height = (collectionView.frame.size.height - 2) / 8
        
//        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setWeekView() {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while current < nextSunday {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
    }
    
    @objc func previousWeek(_ sender: Any)
    {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    
    @objc func nextWeek(_ sender: Any)
    {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}

extension CodeCalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCVCell.identifier, for: indexPath) as! CalendarCVCell
        
        let date = totalSquares[indexPath.item]
//        cell.configure(with: "X")
        cell.configure(with: String(CalendarHelper().dayOfMonth(date: date)))
//        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if date == selectedDate {
            cell.backgroundColor = .systemGreen
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/7),
                                               heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Verital group inside horizontal group
        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitems: [item])
        
//        (
//            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .absolute(390)),
//            subitem: item,
//            count: 1
//        )
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
