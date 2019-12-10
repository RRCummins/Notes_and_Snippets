//
//  ViewController.swift
//  AutoLayout_LBTA
//
//  Created by Ryan Cummins on 12/1/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//


// The ideas are from https://www.youtube.com/watch?v=iqpAP7s3b-8


import UIKit

class ViewController: UIViewController {
  
  var presetStackView = UIStackView()
  var presetLeadingStackView = UIStackView()
  var presetTrailingStackView = UIStackView()
  let preset1 = UIButton(type: .roundedRect)
  let preset2 = UIButton(type: .roundedRect)
  let preset3 = UIButton(type: .roundedRect)
  let preset4 = UIButton(type: .roundedRect)

  override func viewDidLoad() {
    super.viewDidLoad()

    loadPresetButtons()

  }
  
  func loadPresetButtons() {
     [preset1, preset2, preset3, preset4].forEach {view.addSubview($0)}
     presetLeadingStackView = UIStackView(arrangedSubviews: [preset1, preset3])
     presetTrailingStackView = UIStackView(arrangedSubviews: [preset2, preset4])
     presetStackView = UIStackView(arrangedSubviews: [presetLeadingStackView, presetTrailingStackView])
     [presetLeadingStackView, presetTrailingStackView, presetStackView].forEach {view.addSubview($0)}
    configurePresetButtons()
  }
  
  func configurePresetButtons() {

      preset1.backgroundColor = .red
      preset2.backgroundColor = .blue
      preset3.backgroundColor = .green
      preset4.backgroundColor = .systemPink
      
      presetStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, center: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 250))
      presetStackView.distribution = .fillEqually
      
    presetLeadingStackView.anchor(top: presetStackView.topAnchor, leading: presetStackView.leadingAnchor, bottom: presetStackView.bottomAnchor, trailing: presetStackView.centerXAnchor, center: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
      presetLeadingStackView.axis = .vertical
    presetLeadingStackView.distribution = .fillEqually
      
    presetTrailingStackView.anchor(top: presetStackView.topAnchor, leading: presetStackView.centerXAnchor, bottom: presetStackView.bottomAnchor, trailing: presetStackView.trailingAnchor, center: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
      presetTrailingStackView.axis = .vertical
    presetTrailingStackView.distribution = .fillEqually
    }


}

