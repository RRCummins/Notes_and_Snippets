//
//  ViewController.swift
//  ChildViewControllers
//
//  Created by Ryan Cummins on 10/8/19.
//  Copyright © 2019 Them Rhinos. All rights reserved.
//

// The tutorial for this is from https://www.youtube.com/watch?v=B5-1_aR20rE&t=331s

import UIKit

class ViewController: UIViewController {
  
  enum Segues {
    static let toStorBoardVC = "ToStoryBoardVC"
  }
  
  let programmaticVC = ProgramaticVC()

  override func viewDidLoad() {
    super.viewDidLoad()
    setProgrammaticVC()
  }
  
  func setProgrammaticVC() {
    addChild(programmaticVC)
    view.addSubview(programmaticVC.view)
    programmaticVC.view.backgroundColor = .cyan
    // Pass an array to the child here
    programmaticVC.didMove(toParent: self)
    setProgrammaticConstraints()
  }
  
  func setProgrammaticConstraints() {
    programmaticVC.view.translatesAutoresizingMaskIntoConstraints = false
    programmaticVC.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
    programmaticVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    programmaticVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    programmaticVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segues.toStorBoardVC {
      let destVC = segue.destination as! StoryBoardVC
      destVC.view.backgroundColor = .blue
    }
  }


}

