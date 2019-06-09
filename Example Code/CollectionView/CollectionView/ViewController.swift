//
//  ViewController.swift
//  CollectionView
//
//  Created by Ryan Cummins on 6/8/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//  Example from https://www.youtube.com/watch?v=k90V115zqRk

import UIKit

class ViewController: UIViewController {
  
  
  fileprivate let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    return cv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.addSubview(collectionView)
    collectionView.backgroundColor = UIColor(named: "SectionColor")
    collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
    collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
  }


}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
    cell.backgroundColor = UIColor(named: "CellColor")
    return cell
  }
  
  
}

//MArk: - Cell Class
class CustomCell: UICollectionViewCell {
  
  fileprivate let bg: UIImageView = {
    let iv = UIImageView()
    iv.image = #imageLiteral(resourceName: "threeFrisbee")
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleToFill
    iv.clipsToBounds = true
    return iv
    
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(bg)
    bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
