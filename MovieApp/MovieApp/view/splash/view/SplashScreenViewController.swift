//
//  SplashScreenViewController.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/20/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit
import Lottie
class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let animationView = LOTAnimationView(name: "preLoader")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        
        view.addSubview(animationView)
        
        animationView.play{ (finished) in
            animationView.play{ (finished) in
                // Do Something
                animationView.play{ (finished) in
                    // Do Something
                    self.performSegue(withIdentifier: "loader", sender: self)
                }
            }
        }
    }
    
    
}

