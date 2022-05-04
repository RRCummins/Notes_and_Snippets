//
//  SecondVC.swift
//  CacheExample
//
//  Created by Ryan Cummins on 5/3/22.
//

import UIKit

class SecondVC: UIViewController {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        ImageProvider.shared.fetchImage(urlString: "https://source.unsplash.com/random/500x500") { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }

}
