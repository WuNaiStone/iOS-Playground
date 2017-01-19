//
//  ViewController.swift
//  DemoLTMorphingLabel
//
//  Created by Chris Hu on 17/1/19.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import LTMorphingLabel

class ViewController: UIViewController {

    var myLabel: LTMorphingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
            self.myLabel = LTMorphingLabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
            self.myLabel.center = self.view.center
            self.myLabel.font = UIFont.systemFont(ofSize: 30)
            self.myLabel.textColor = UIColor.white
            self.myLabel.textAlignment = .center
            self.view.addSubview(self.myLabel)
            self.myLabel.text = "LTMorphingLabel"
            
            self.myLabel.morphingDuration = 1.0
            self.myLabel.morphingEffect = .sparkle
        }
    }


}

