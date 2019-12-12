//
//  AnimatedCircle.swift
//  Circular-Progress-Bar
//
//  Created by Ryan Cummins on 12/10/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class AnimatedCircle: UIView {
  
  let shapeLayer = CAShapeLayer()
  let trackPath = CAShapeLayer()
  
  var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
  var baseColor: CGColor = UIColor.lightGray.cgColor
  var topColor: CGColor = UIColor.red.cgColor
  
  var lineWidth: CGFloat = 10
  var radius: CGFloat = 50
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }
  
  convenience init(centerPoint: CGPoint) {
    self.init()
    self.centerPoint = centerPoint
    setUp()
  }
  
  convenience init(centerPoint: CGPoint, baseColor: CGColor, topColor: CGColor, lineWidth: CGFloat, radius: CGFloat) {
    self.init()
    self.centerPoint = centerPoint
    self.baseColor = baseColor
    self.topColor = topColor
    self.lineWidth = lineWidth
    self.radius = radius
    setUp()
  }
  
  private func setUp() {
    addTrackPath(center: centerPoint)
    addAnimatedPath(center: centerPoint)
  }

  func addTrackPath(center: CGPoint) {
    let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    trackPath.path = circularPath.cgPath
    trackPath.strokeColor = baseColor
    trackPath.lineWidth = lineWidth
    trackPath.fillColor = UIColor.clear.cgColor
    trackPath.lineCap = CAShapeLayerLineCap.round
    
    layer.addSublayer(trackPath)
  }
  
  func addAnimatedPath(center: CGPoint) {
    let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    shapeLayer.path = circularPath.cgPath
    shapeLayer.strokeColor = topColor
    shapeLayer.lineWidth = lineWidth
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeEnd = 0
    shapeLayer.lineCap = CAShapeLayerLineCap.round
    
    layer.addSublayer(shapeLayer)
  }
  
  /*
   Add Gesture Recognizer to activate animation
   i.e.
   view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
   
   @objc func handleTap() {
   circle1.animateCircle()
   }
   */
  func animateCircle() {
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    basicAnimation.toValue = 1
    basicAnimation.duration = 2
    
    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "urSoBasic")
  }
  

}
