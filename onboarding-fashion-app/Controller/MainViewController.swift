//
//  MainViewController.swift
//  onboarding-fashion-app
//
//  Created by trungnghia on 4/27/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BackToOnboardingTapped(_ sender: Any) {
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "onboardingView")
        
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
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
