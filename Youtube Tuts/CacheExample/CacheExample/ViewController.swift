//
//  ViewController.swift
//  CacheExample
//
//  Created by Ryan Cummins on 5/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    let button:UIButton = {
       let button = UIButton()
        button.setTitle("Tap me", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        button.center = view.center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        let vc = SecondVC()
        present(vc, animated: true)
    }


}

