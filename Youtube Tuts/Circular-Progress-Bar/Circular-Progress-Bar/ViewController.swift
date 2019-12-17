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
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var shapeLayer = CAShapeLayer()
    var trackPath = CAShapeLayer()
    var pulsatingLayer: CAShapeLayer!
    
    var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
    var baseColor: CGColor = UIColor.lightGray.cgColor
    var topColor: CGColor = UIColor.red.cgColor
    
    var lineWidth: CGFloat = 10
    var radius: CGFloat = 100
    
    fileprivate func addPercentageLabel() {
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotificationObservers()
        
        
        view.backgroundColor = .backgroundColor
        centerPoint = view.center
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        setUp()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
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
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = percentage
        }
        //      print(percentage)
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
        addPulsatingLayer(center: centerPoint)
        addTrackPath(center: centerPoint)
        addAnimatedPath(center: centerPoint)
        
        addPercentageLabel()
    }
    
    func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor, startAngle: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = view.center
        return layer
    }
    
    func addPulsatingLayer(center: CGPoint) {
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: .pulsatingFillColor, startAngle: -CGFloat.pi / 2)
        view.layer.addSublayer(pulsatingLayer)
        
        animatePulsatingLayer()
    }
    
    func addTrackPath(center: CGPoint) {
        trackPath = createCircleShapeLayer(strokeColor: .trackStrokeColor, fillColor: .backgroundColor, startAngle: -CGFloat.pi / 2)
        view.layer.addSublayer(trackPath)
    }
    
    func addAnimatedPath(center: CGPoint) {
        shapeLayer = createCircleShapeLayer(strokeColor: .outlineStrokeColor, fillColor: .clear, startAngle: 0)

        shapeLayer.lineWidth = 20
        shapeLayer.strokeEnd = 0
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        view.layer.addSublayer(shapeLayer)
    }
    
    func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsating")
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

