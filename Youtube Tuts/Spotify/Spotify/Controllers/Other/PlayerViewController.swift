//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Ryan Cummins on 2/22/21.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelagate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    weak var delagate: PlayerViewControllerDelagate?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
//        iv.backgroundColor = .systemBlue
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let controlsView = PlayerControlsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        
        controlsView.delegate = self
        
        configureBarButtons()
        configureDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width)
        controlsView.frame = CGRect(
            x: 10,
            y: imageView.bottom+10,
            width: view.width-20,
            height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
    }
    
    private func configureDataSource() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewModel(
            title: dataSource?.songName,
            subtitle: dataSource?.subtitle))
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    public func refreshUI() {
        configureDataSource()
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Actions
    }


}

extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delagate?.didSlideSlider(value)
    }
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        delagate?.didTapPlayPause()
    }
    
    func playerControlsViewDidBackwardsButton(_ playerControlsView: PlayerControlsView) {
        delagate?.didTapBackward()
    }
    
    func playerControlsViewDidForwardButton(_ playerControlsView: PlayerControlsView) {
        delagate?.didTapForward()
    }
    
    
}
