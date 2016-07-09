//
//  ViewController.swift
//  DemoTimeline
//
//  Created by Chris Hu on 16/7/9.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit
import ISTimeline

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.demoTimeline()
    }

    func demoTimeline() {
        let timeline = ISTimeline(frame: self.view.frame)
        self.view.addSubview(timeline)
        
        timeline.backgroundColor = UIColor.whiteColor()
        timeline.bubbleColor = UIColor.greenColor()
        timeline.titleColor = UIColor.blackColor()
        timeline.descriptionColor = UIColor.darkGrayColor()
        timeline.pointDiameter = 7.0
        timeline.lineWidth = 2.0
        timeline.bubbleRadius = 0.0
        
        for index in 0...10 {
            let point = ISPoint(title: "Point \(index)")
            point.description = "My description My description My description My description My description My description My description My description My description My description"
            point.lineColor = index % 2 == 0 ? UIColor.greenColor() : UIColor.redColor()
            point.pointColor = point.lineColor
            point.touchUpInside = { (point: ISPoint) in
                print(point.title)
            }
        
            timeline.points.append(point)
        }
        
    }


}

