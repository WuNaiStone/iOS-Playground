//
//  ViewController.swift
//  DemoEAIntroView
//
//  Created by Chris Hu on 17/1/23.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import EAIntroView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.green
        
        showIntroPages()
    }

    func showIntroPages() {
        let page1: EAIntroPage = EAIntroPage()
        page1.title = "page1"
        page1.bgImage = UIImage(named: "1.png")

        let page2: EAIntroPage = EAIntroPage()
        page2.title = "page2"
        page2.bgImage = UIImage(named: "2.jpg")

        let page3: EAIntroPage = EAIntroPage()
        page3.title = "page3"
        page3.bgImage = UIImage(named: "3.png")

        let introView: EAIntroView = EAIntroView(frame: view.bounds, andPages: [page1, page2, page3])
        introView.delegate = self
        introView.show(in: view, animateDuration: 0.3)
        
        introView.skipButtonAlignment = .center;
        introView.skipButtonY = 80;
        introView.pageControlY = 42;
    }
    
}

extension ViewController: EAIntroDelegate {
    
    func introWillFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
        
    }
    
    func introDidFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
        print(#function)
    }
    
    func intro(_ introView: EAIntroView!, pageAppeared page: EAIntroPage!, with pageIndex: UInt) {
    
    }
    
    func intro(_ introView: EAIntroView!, pageStartScrolling page: EAIntroPage!, with pageIndex: UInt) {
    
    }
    
    func intro(_ introView: EAIntroView!, pageEndScrolling page: EAIntroPage!, with pageIndex: UInt) {
    
    }
    
    func intro(_ introView: EAIntroView!, didScrollWithOffset offset: CGFloat) {
    
    }
    
}

