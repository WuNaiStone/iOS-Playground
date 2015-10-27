//
//  BViewController.swift
//  DemoNavigationController
//
//  Created by zj－db0465 on 15/10/27.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class BViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("\(self.description) : \(__FUNCTION__)")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("\(self.description) : \(__FUNCTION__)")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(self.description) : \(__FUNCTION__)")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(self.description) : \(__FUNCTION__)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(self.description) : \(__FUNCTION__)")
    }
    
    @IBAction func actionToRoot(sender: AnyObject) {
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
}
