//
//  ViewController.swift
//  MovieApp
//
//  Created by Esraa Hassan on 5/10/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit
import Lottie
class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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

