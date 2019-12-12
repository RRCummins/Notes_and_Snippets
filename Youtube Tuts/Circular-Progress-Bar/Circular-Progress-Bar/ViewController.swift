//
//  ViewController.swift
//  Circular-Progress-Bar
//
//  Created by Ryan Cummins on 12/9/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var circle1 = AnimatedCircle()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    circle1 = AnimatedCircle(centerPoint: view.center, baseColor: UIColor.lightGray.cgColor, topColor: UIColor.blue.cgColor, lineWidth: 10, radius: 100)
    
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    view.addSubview(circle1)
  }
  
  @objc func handleTap() {
//    print("trying to handle")
    circle1.animateCircle()
  }


}

