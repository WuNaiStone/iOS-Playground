//
//  ItemViewController.swift
//  DemoGestureRecognizer
//
//  Created by zj－db0465 on 15/11/4.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var greenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addGesture(self.title!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGesture(gesture: String) {
        //        gestures = ["UITapGestureRecognizer", "UIPinchGestureRecognizer",
        //            "UISwipeGestureRecognizer", "UIPanGestureRecognizer",
        //            "UIRotationGestureRecognizer", "UILongPressGestureRecognizer",
        //            "UIScreenEdgePanGestureRecognizer"
        //        ]
        switch gesture {
        case "UITapGestureRecognizer":
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: "actionGesture:")
            self.greenView.addGestureRecognizer(gestureRecognizer)
            break
        case "UIPinchGestureRecognizer":
            let gestureRecognizer = UIPinchGestureRecognizer(target: self, action: "actionGesture:")
            self.greenView.addGestureRecognizer(gestureRecognizer)
            break
        case "UISwipeGestureRecognizer":
            let left = UISwipeGestureRecognizer(target: self, action: "actionGesture:")
            left.direction = UISwipeGestureRecognizerDirection.Left
            self.greenView.addGestureRecognizer(left)
            
            let right = UISwipeGestureRecognizer(target: self, action: "actionGesture:")
            right.direction = UISwipeGestureRecognizerDirection.Right
            self.greenView.addGestureRecognizer(right)
            
            let up = UISwipeGestureRecognizer(target: self, action: "actionGesture:")
            up.direction = UISwipeGestureRecognizerDirection.Up
            self.greenView.addGestureRecognizer(up)
            
            let down = UISwipeGestureRecognizer(target: self, action: "actionGesture:")
            down.direction = UISwipeGestureRecognizerDirection.Down
            self.greenView.addGestureRecognizer(down)
            break
        case "UIPanGestureRecognizer":
            let gestureRecognizer = UIPanGestureRecognizer(target: self, action: "actionGesture:")
            self.greenView.addGestureRecognizer(gestureRecognizer)
            break
        case "UIRotationGestureRecognizer":
            let gestureRecognizer = UIRotationGestureRecognizer(target: self, action: "actionGesture:")
            self.greenView.addGestureRecognizer(gestureRecognizer)
            break
        case "UILongPressGestureRecognizer":
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "actionGesture:")
            gestureRecognizer.minimumPressDuration = 2
            gestureRecognizer.allowableMovement = 15
            self.greenView.addGestureRecognizer(gestureRecognizer)
            break
        case "UIScreenEdgePanGestureRecognizer":
            let gestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "actionGesture:")
            self.greenView.addGestureRecognizer(gestureRecognizer)
            break
        default:
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: "actionGesture:")
            self.greenView.addGestureRecognizer(gestureRecognizer)
            break
        }
    }
    
    func actionGesture(gesture: AnyObject) {
        let gestureType = NSStringFromClass(gesture.classForCoder)
        switch gestureType {
        case "UITapGestureRecognizer":
            self.greenView.backgroundColor = UIColor.blueColor()
            break
        case "UIPinchGestureRecognizer":
            let g: UIPinchGestureRecognizer = gesture as! UIPinchGestureRecognizer
            self.greenView.transform = CGAffineTransformMakeScale(g.scale, g.scale)
            break
        case "UISwipeGestureRecognizer":
            let g: UISwipeGestureRecognizer = gesture as! UISwipeGestureRecognizer
            switch g.direction {
            case UISwipeGestureRecognizerDirection.Left:
                self.greenView.backgroundColor = UIColor.redColor()
                break
            case UISwipeGestureRecognizerDirection.Right:
                self.greenView.backgroundColor = UIColor.blueColor()
                break
            case UISwipeGestureRecognizerDirection.Up:
                self.greenView.backgroundColor = UIColor.grayColor()
                break
            case UISwipeGestureRecognizerDirection.Down:
                self.greenView.backgroundColor = UIColor.yellowColor()
                break
            default:
                break
            }
            break
        case "UIPanGestureRecognizer":
            
            break
        case "UIRotationGestureRecognizer":
            
            break
        case "UILongPressGestureRecognizer":
            self.greenView.backgroundColor = UIColor.blueColor()
            break
        case "UIScreenEdgePanGestureRecognizer":
            
            break
        default:
            
            break
        }
    }
    

    @IBAction func actionReset(sender: UIButton) {
        self.greenView.backgroundColor = UIColor.greenColor()
        self.greenView.transform = CGAffineTransformMakeScale(1.0, 1.0)
    }
    
    
}
