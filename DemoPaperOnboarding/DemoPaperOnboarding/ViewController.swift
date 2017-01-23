//
//  ViewController.swift
//  DemoPaperOnboarding
//
//  Created by Chris Hu on 17/1/23.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import paper_onboarding

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paper = PaperOnboarding()
        paper.backgroundColor = UIColor.lightGray
        paper.dataSource = self
        paper.delegate = self
        view.addSubview(paper)
        
        // add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
          let constraint = NSLayoutConstraint(item: paper,
                                              attribute: attribute,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: attribute,
                                              multiplier: 1,
                                              constant: 0)
          view.addConstraint(constraint)
        }
    }

}

extension ViewController: PaperOnboardingDataSource {
    /**
     Asks the data source to return the number of items.
     
     - parameter index: An index of item in PaperOnboarding.
     
     - returns: The number of items in PaperOnboarding.
     */
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    /**
     Asks the data source for configureation item.
     
     - parameter index: An index of item in PaperOnboarding.
     
     - returns: configuration info for item
     
public typealias OnboardingItemInfo = (imageName: String, title: String, description: String, iconName: String, color: UIColor, titleColor: UIColor, descriptionColor: UIColor, titleFont: UIFont, descriptionFont: UIFont)
     */
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let bgColor = UIColor(red:0.40, green:0.56, blue:0.71, alpha:1.00)
        let titleColor = UIColor.white
        let descriptionColor = UIColor.blue
        let titleFont = UIFont.systemFont(ofSize: 30)
        let descriptionFont = UIFont.systemFont(ofSize: 20)
        return [
            ("1.png", "Title", "Description text", "IconName1", bgColor, titleColor, descriptionColor, titleFont, descriptionFont),
            ("2.jpg", "Title", "Description text", "IconName1", bgColor, titleColor, descriptionColor, titleFont, descriptionFont),
            ("3.png", "Title", "Description text", "IconName1", bgColor, titleColor, descriptionColor, titleFont, descriptionFont),
            ][index]
    }
}

extension ViewController: PaperOnboardingDelegate {
    /**
     Tells the delegate that the paperOnbording start scrolling.
     
     - parameter index: An curretn index item
     */
    func onboardingWillTransitonToIndex(_ index: Int) {}
    
    /**
     Tells the delegate that the specified item is now selected
     
     - parameter index: An curretn index item
     */
    func onboardingDidTransitonToIndex(_ index: Int) {}
    
    /**
     Tells the delegate the PaperOnboarding is about to draw a item for a particular row. Use this method for configure items
     
     - parameter item:  A OnboardingContentViewItem object that PaperOnboarding is going to use when drawing the row.
     - parameter index: An curretn index item
     */
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int){
        //    item.titleLabel?.backgroundColor = .redColor()
        //    item.descriptionLabel?.backgroundColor = .redColor()
        //    item.imageView = ...
    }
}

