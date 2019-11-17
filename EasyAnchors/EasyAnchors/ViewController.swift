//
//  ViewController.swift
//  EasyAnchors
//
//  Created by Ryan Cummins on 11/17/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let redView = UIView()
    redView.backgroundColor = .red
    view.addSubview(redView)
    
    redView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    
  }
  
}


extension UIView {
  func anchor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor, padding: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
    leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
    bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
    trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
  }
}
