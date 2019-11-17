//
//  CustomSegmentedButton.swift
//  Custom-Segmented-Button
//
//  Created by Ryan Cummins on 10/10/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

import UIKit

class CustomSegmentedButton: UIButton {

    // From https://medium.com/code-with-coffee/create-a-custom-segmented-control-6488400f8705
      
      private var buttonTitles: [String]!
      private var buttons: [UIButton] = []
      private var selectorView: UIView!
      private var _selectedIndex: Int = 0
      public var selectedIndex: Int {
        return _selectedIndex
      }
      
      var textColor: UIColor = .black
      var selectorViewColor: UIColor = .red
      var selectorTextColor: UIColor = .red
      
      weak var delegate:CustomSegmentedControlDelegate?
      
      
      func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
      }
      
      private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        
        selectorView = UIView(frame: CGRect(x: 0,
                                            y: self.frame.height,
                                            width: selectorWidth,
                                            height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
      }
      
      
      private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
          let button = UIButton(type: .system)
          button.setTitle(buttonTitle, for: .normal)
          button.addTarget(self, action: #selector(CustomSegmentedButton.buttonAction(sender:)), for: .touchUpInside)
          button.setTitleColor(textColor, for: .normal)
          buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
      }
      

      @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
    //      print(buttonIndex,", ", btn)
          btn.setTitleColor(textColor, for: .normal)
          if btn == sender {
            let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
            delegate?.changeToIndex(index: buttonIndex)
            UIView.animate(withDuration: 0.3) {
              self.selectorView.frame.origin.x = selectorPosition
            }
            btn.setTitleColor(selectorTextColor, for: .normal)
          }
        }
      }
      
      
      func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal)})
        let button = buttons[index]
        _selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
          self.selectorView.frame.origin.x = selectorPosition
        }
      }
      
      
      private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
      }
      
      
      convenience init(frame:CGRect, buttonTitle:[String]) {
        self.init(frame: frame)
        //This init is slightly different than the ex
        self.buttonTitles = buttonTitle
      }
      
      
      override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
      }
      
      func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
      }
      

    }



    protocol CustomSegmentedControlDelegate:class {
      func changeToIndex(index:Int)
    }
