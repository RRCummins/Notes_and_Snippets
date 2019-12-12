//
//  ViewController.swift
//  Circular-Progress-Bar
//
//  Created by Ryan Cummins on 12/9/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//


// example from https://www.youtube.com/watch?v=ZaW-xPmjutA

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
  
  let urlSring = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
  
  var circle1 = AnimatedCircle()
  var percentageComplete: CGFloat = 0
  
  let percentageLabel: UILabel  {
    let label = UILabel()
    label.text = "Start"
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 32)
    return label
  }
  
  let shapeLayer = CAShapeLayer()
  let trackPath = CAShapeLayer()
  var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
  var baseColor: CGColor = UIColor.lightGray.cgColor
  var topColor: CGColor = UIColor.red.cgColor

  var lineWidth: CGFloat = 10
  var radius: CGFloat = 100
  
  override func viewDidLoad() {
    super.viewDidLoad()
    centerPoint = view.center
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
//    view.addSubview(circle1)
    setUp()
  }
  
  func begindDownloadingFile() {
    
    shapeLayer.strokeEnd = 0
  
    let configuration = URLSessionConfiguration.default
    let operationQueue = OperationQueue()
    let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
    
    guard let url = URL(string: urlSring) else { return }
    let downloadTask = urlSession.downloadTask(with: url)
    downloadTask.resume()
  }
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
  //    print(totalBytesWritten, totalBytesExpectedToWrite)
      
      let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
      
      DispatchQueue.main.async {
        self.shapeLayer.strokeEnd = percentage
      }
      
      print(percentage)
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
      print("Finished downloading file")
    }
  
  @objc func handleTap() {
//    print("trying to handle")
    begindDownloadingFile()
//    animateCircle()
  }

   private func setUp() {
     addTrackPath(center: centerPoint)
     addAnimatedPath(center: centerPoint)
   }

   func addTrackPath(center: CGPoint) {
    let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
     trackPath.path = circularPath.cgPath
     trackPath.strokeColor = baseColor
     trackPath.lineWidth = lineWidth
     trackPath.fillColor = UIColor.clear.cgColor
     trackPath.lineCap = CAShapeLayerLineCap.round
     trackPath.position = view.center
     
    view.layer.addSublayer(trackPath)
   }
   
   func addAnimatedPath(center: CGPoint) {
    let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
     shapeLayer.path = circularPath.cgPath
     shapeLayer.strokeColor = topColor
     shapeLayer.lineWidth = lineWidth
     shapeLayer.fillColor = UIColor.clear.cgColor
     shapeLayer.strokeEnd = 0
     shapeLayer.lineCap = CAShapeLayerLineCap.round
     shapeLayer.position = view.center
    
    shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
     
    view.layer.addSublayer(shapeLayer)
   }

  
   func animateCircle() {
     let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
     
     basicAnimation.toValue = 1
     basicAnimation.duration = 2
     
     basicAnimation.fillMode = CAMediaTimingFillMode.forwards
     basicAnimation.isRemovedOnCompletion = false
     
     shapeLayer.add(basicAnimation, forKey: "urSoBasic")
   }
   


}

