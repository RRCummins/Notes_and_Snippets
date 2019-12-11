//
//  AnimatedCircle.swift
//  Circular-Progress-Bar
//
//  Created by Ryan Cummins on 12/10/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class AnimatedCircle: UIView {
  let centerPoint: CGPoint
  let shapeLayer = CAShapeLayer()
  let trackPath = CAShapeLayer()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }
  
  convenience init(centerPoint: CGPoint) {
    self.init(frame: .zero)
    self.centerPoint = centerPoint
//    setUp()
  }
  
  
  
  func setUp() {
    
    addTrackPath(center: centerPoint)
    addAnimatedPath(center: centerPoint)
    layer.addSublayer(trackPath)
  }

  
  func addTrackPath(center: CGPoint) {

    let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    trackPath.path = circularPath.cgPath
    trackPath.strokeColor = UIColor.lightGray.cgColor
    trackPath.lineWidth = 10
    trackPath.fillColor = UIColor.clear.cgColor
    trackPath.lineCap = CAShapeLayerLineCap.round
    
    layer.addSublayer(trackPath)
  }
  
  func addAnimatedPath(center: CGPoint) {
    let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    shapeLayer.path = circularPath.cgPath
    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.lineWidth = 10
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeEnd = 0
    shapeLayer.lineCap = CAShapeLayerLineCap.round
    
    
    layer.addSublayer(shapeLayer)
    
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
  }
  
  private func beginDownloadingFile() {
    print("Attempting to download file")
  }
  
  fileprivate func animateCircle() {
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    basicAnimation.toValue = 1
    
    basicAnimation.duration = 2
    
    basicAnimation.fillMode = CAMediaTimingFillMode.forwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "urSoBasic")
  }
  
  @objc private func handleTap() {
    print("Attempting to animate stroke")
    
    beginDownloadingFile()
    
    animateCircle()
    
  }
  
  

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
