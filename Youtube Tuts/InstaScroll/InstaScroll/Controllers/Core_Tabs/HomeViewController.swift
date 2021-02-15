//
//  ViewController.swift
//  InstaScroll
//
//  Created by Ryan Cummins on 2/4/21.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        handleNotAuthenticated()
        
//        // Auto sign out for debug
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print("failed to sign out")
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func handleNotAuthenticated() {
        // CHeck auth status
        if Auth.auth().currentUser == nil {
            // Show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }


}

