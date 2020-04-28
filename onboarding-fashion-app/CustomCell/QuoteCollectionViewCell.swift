//
//  QuoteCollectionViewCell.swift
//  onboarding-fashion-app
//
//  Created by trungnghia on 4/27/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class QuoteCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var exploreButton: UIButton!
    
    func configure(with item: OnboardingItem) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
    }
    
    func showExploreButton(_ shouldShow: Bool) {
        exploreButton.isHidden = !shouldShow
    }
    
    
    @IBAction func exploreButtonTapped(_ sender: UIButton) {
        showMainAppView()
    }
    
    private func showMainAppView() {
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "mainViewController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = mainView
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
            
        
    }
    
}
