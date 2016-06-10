//
//  ItemViewController.swift
//  DemoRealm
//
//  Created by Chris Hu on 16/5/4.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import RealmSwift

class ItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        self.addButtons()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func addButtons() {
        let btn1 = UIButton(frame: CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 50))
        btn1.setTitle("Add Task", forState: UIControlState.Normal)
        btn1.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn1.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn1.layer.borderColor = UIColor.redColor().CGColor
        btn1.layer.borderWidth = 2.0
        btn1.addTarget(self, action: #selector(ItemViewController.actionAddTask), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50))
        btn2.setTitle("Query Task", forState: UIControlState.Normal)
        btn2.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btn2.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        btn2.layer.borderColor = UIColor.redColor().CGColor
        btn2.layer.borderWidth = 2.0
        btn2.addTarget(self, action: #selector(ItemViewController.actionQueryTask), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn2)
    }
    
    func actionAddTask() {
        self.actionAddPomodoro()
        return
        
        let taskListA = TaskList()
        taskListA.name = "Wish List"
        
        let wish1 = Task()
        wish1.name = "iPhone 6s"
        wish1.notes = "64 GB, Gold"
        
        let wish2 = Task(value: ["name": "Game Console", "notes": "Playstation 4, 1 TB"])
        let wish3 = Task(value: ["Car", NSDate(), "Auto R8", false])
        
        taskListA.tasks.appendContentsOf([wish1, wish2, wish3])
        
        //        let taskListB = TaskList(value: ["MoviesList", NSDate(), [["The Martian", NSDate(), "", false], ["The Maze Runner", NSDate(), "", true]]])
        
        do {
            try uiRealm.write { () -> Void in
                    uiRealm.add([taskListA])
                }
        } catch {
        
        }
    }
    
    func actionQueryTask() {
        self.actionQueryPomodoro()
        return
        
        let tasks = uiRealm.objects(Task)
        print(tasks)
    }

    
    func actionAddPomodoro() {
        let pomodoro = ModelPomodoroRealm(value: ["createTime": NSDate(), "endTime": NSDate().dateByAddingTimeInterval(60*30), "duration": 60*30])
        do {
            try pomodoroRealm.write { () -> Void in
                pomodoroRealm.add([pomodoro])
            }
        } catch {
        
        }
    }
    
    func actionQueryPomodoro() {
        var pomodoros : Results<ModelPomodoroRealm>!
        pomodoros = pomodoroRealm.objects(ModelPomodoroRealm)
        print("pomodoros : \(pomodoros)")
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
}
