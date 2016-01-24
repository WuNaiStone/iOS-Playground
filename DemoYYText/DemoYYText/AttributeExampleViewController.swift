//
//  AttributeExampleViewController.swift
//  DemoYYText
//
//  Created by zj－db0465 on 16/1/23.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

class AttributeExampleViewController: UIViewController {

    var text = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = NSStringFromClass(self.classForCoder)
        
        let label = YYLabel()
        label.frame = self.view.frame
        label.textAlignment = NSTextAlignment.Center
        label.textVerticalAlignment = YYTextVerticalAlignment.Center
        label.numberOfLines = 0
        self.view.addSubview(label)
    
        self.addAttributes()
        
        label.attributedText = self.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func nextLine() -> NSAttributedString {
        let next = NSMutableAttributedString(string: "\n\n")
        next.yy_font = UIFont.systemFontOfSize(4)
        return next
    }
    
    func addAttributes() {
        // 外阴影
        self.addShadow()
        
        // 内阴影        
        self.addInnerShadow()
        
        self.addMultiShadow()
        
        self.addBorder()
    }
    
    func addShadow() {
        let textShadow: NSMutableAttributedString = NSMutableAttributedString(string: "Shadow")
        textShadow.yy_font = UIFont.systemFontOfSize(30)
        textShadow.yy_color = UIColor.whiteColor()
        
        let shadow = YYTextShadow()
        shadow.color = UIColor(white: 0.0, alpha: 0.5)
        shadow.offset = CGSizeMake(0, 1)
        shadow.radius = 5
        
        textShadow.yy_textShadow = shadow
        
        self.text.appendAttributedString(textShadow)
        self.text.appendAttributedString(self.nextLine())
    }
    
    func addInnerShadow() {
        let textInnerShadow: NSMutableAttributedString = NSMutableAttributedString(string: "Inner Shadow")
        textInnerShadow.yy_font = UIFont.systemFontOfSize(30)
        textInnerShadow.yy_color = UIColor.whiteColor()
        
        let innerShadow = YYTextShadow()
        innerShadow.color = UIColor(white: 0.0, alpha: 0.5)
        innerShadow.offset = CGSizeMake(0, 1)
        innerShadow.radius = 1
        
        textInnerShadow.yy_textInnerShadow = innerShadow
    
        self.text.appendAttributedString(textInnerShadow)
        self.text.appendAttributedString(self.nextLine())
    }
    
    func addMultiShadow() {
        let textMultiShadow = NSMutableAttributedString(string: "Multiple Shadow")
        textMultiShadow.yy_font = UIFont.systemFontOfSize(30)
        textMultiShadow.yy_color = UIColor.whiteColor()
        
        let shadow = YYTextShadow()
        shadow.color = UIColor(white: 0.0, alpha: 0.5)
        shadow.offset = CGSizeMake(0, 1)
        shadow.radius = 5
        let subShadow = YYTextShadow()
        subShadow.color = UIColor.redColor()
        subShadow.offset = CGSizeMake(0, 1)
        subShadow.radius = 1.5
        shadow.subShadow = subShadow
        
        textMultiShadow.yy_textShadow = shadow
        
        let innerShadow = YYTextShadow()
        innerShadow.color = UIColor(white: 0.0, alpha: 0.5)
        innerShadow.offset = CGSizeMake(0, 1)
        innerShadow.radius = 1
        
        textMultiShadow.yy_textInnerShadow = innerShadow
        
        self.text.appendAttributedString(textMultiShadow)
        self.text.appendAttributedString(self.nextLine())
    }
    
    func addBorder() {
        let textBorder = NSMutableAttributedString(string: "Border")
        textBorder.yy_font = UIFont.systemFontOfSize(30)
        textBorder.yy_color = UIColor.blueColor()
        
        let border = YYTextBorder()
        border.strokeColor = UIColor.redColor()
        border.strokeWidth = 3
        border.cornerRadius = 3
        border.lineStyle = YYTextLineStyle.PatternCircleDot
        border.insets = UIEdgeInsetsMake(0, -4, 0, -4)
        
        textBorder.yy_textBackgroundBorder = border
        
        self.text.appendAttributedString(textBorder)
        self.text.appendAttributedString(self.nextLine())
    }
    
}
