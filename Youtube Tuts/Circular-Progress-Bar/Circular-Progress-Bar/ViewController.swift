//
//  ViewController.swift
//  Circular-Progress-Bar
//
//  Created by Ryan Cummins on 12/9/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let shapeLayer = CAShapeLayer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let center = view.center
    let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    shapeLayer.path = circularPath.cgPath
    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.lineWidth = 10
    shapeLayer.strokeEnd = 0
    
    
    
    view.layer.addSublayer(shapeLayer)
    
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
  }
  
  @objc func handleTap() {
    print("Attempting to handle tap gesture")
    
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    basicAnimation.toValue = 1
    
    basicAnimation.duration = 2
    
    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false
    
    
    shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    
  }


}

