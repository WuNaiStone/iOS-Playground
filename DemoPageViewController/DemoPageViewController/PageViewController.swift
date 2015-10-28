//
//  PageViewController.swift
//  DemoPageViewController
//
//  Created by zj－db0465 on 15/10/27.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,
    UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageCount: Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.dataSource = self
        self.delegate = self
        
        let startPage: PageContentViewController = self.viewControllerAtIndex(0)
        
        self.setViewControllers([startPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let page: PageContentViewController = viewController as! PageContentViewController
        let index: Int = page.pageIndex
        if (index == 0) {
            return nil
        }
        return self.viewControllerAtIndex(page.pageIndex - 1)
    }

    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let page: PageContentViewController = viewController as! PageContentViewController
        let index: Int = page.pageIndex
        if (index == pageCount) {
            return nil
        }
        return self.viewControllerAtIndex(page.pageIndex + 1)
    }
    
    public func viewControllerAtIndex(index: Int) -> PageContentViewController {
        let page: PageContentViewController = PageContentViewController()
        page.pageIndex = index
        return page
    }
}
