//
//  ViewController.swift
//  DemoHelloAI
//
//  Created by Chris Hu on 17/1/18.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var perception: Perception!
    
    var btnTrain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let top = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        top.backgroundColor = UIColor.red
        view.addSubview(top)
        
        let bottom = UIView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height - 200))
        bottom.backgroundColor = UIColor.blue
        view.addSubview(bottom)
        
        btnTrain = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        view.addSubview(btnTrain)
        btnTrain.center = view.center
        btnTrain.setTitle("Train", for: .normal)
        btnTrain.addTarget(self, action: #selector(ViewController.actionBtnTrain), for: .touchUpInside)
    }

    func actionBtnTrain() {
        btnTrain.isEnabled = false
        
        perception = Perception()
        
        trainPerception()
        
        btnTrain.removeFromSuperview()
        btnTrain = nil
    }
    
    func trainPerception() {
        print("Perception has started its training.")
        
        for _ in 0...100000000 {
            let x = Int(arc4random()) % Int(view.frame.size.width)
            let y = Int(arc4random()) % Int(view.frame.size.height)
            
            var result: Int
            
            if y < 200 {
                result = 1
                perception.train(inputs: [Float(x), Float(y), 1.0], desired: result)
            } else {
                result = -1
                perception.train(inputs: [Float(x), Float(y), 1.0], desired: result)
            }
        }
        
        print("Perception has finished its training.")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if perception == nil {
            return
        }
        
        if let touchPoint = touches.first?.location(in: view) {
            let result = perception.feedback(inputs: [Float(touchPoint.x), Float(touchPoint.y), 1.0])
            if result == 1 {
                print("Red : \(touchPoint.x), \(touchPoint.y)")
            } else {
                print("Blue : \(touchPoint.x), \(touchPoint.y)")
            }
        }
    }

}

