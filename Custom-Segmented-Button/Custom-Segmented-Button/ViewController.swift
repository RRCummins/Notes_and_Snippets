//
//  ViewController.swift
//  Custom-Segmented-Button
//
//  Created by Ryan Cummins on 10/10/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let codeSegmented = CustomSegmentedButton(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["Screen 1", "Screen 2", "Screen 3"])
      codeSegmented.backgroundColor = .clear
      view.addSubview(codeSegmented)
    
  }


}

