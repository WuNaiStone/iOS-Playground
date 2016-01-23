//
//  MarkDownExampleViewController.swift
//  DemoYYText
//
//  Created by zj－db0465 on 15/11/16.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class MarkDownExampleViewController: UIViewController, YYTextViewDelegate {

    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSStringFromClass(self.classForCoder)

        // Do any additional setup after loading the view.
        
        text = "#Markdown Editor\nThis is a simple markdown editor based on `YYTextView`.\n\n*********************************************\nIt\'s *italic* style.\n\nIt\'s also _italic_ style.\n\nIt\'s **bold** style.\n\nIt\'s ***italic and bold*** style.\n\nIt\'s __underline__ style.\n\nIt\'s ~~deleteline~~ style.\n\n\nHere is a link: [YYKit](https://github.com/ibireme/YYKit)\n\nHere is some code:\n\n\tif(a){\n\t\tif(b){\n\t\t\tif(c){\n\t\t\t\tprintf(\"haha\");\n\t\t\t}\n\t\t}\n\t}\n#Markdown Editor\nThis is a simple markdown editor based on `YYTextView`.\n\n*********************************************\nIt\'s *italic* style.\n\nIt\'s also _italic_ style.\n\nIt\'s **bold** style.\n\nIt\'s ***italic and bold*** style.\n\nIt\'s __underline__ style.\n\nIt\'s ~~deleteline~~ style.\n\n\nHere is a link: [YYKit](https://github.com/ibireme/YYKit)\n\nHere is some code:\n\n\tif(a){\n\t\tif(b){\n\t\t\tif(c){\n\t\t\t\tprintf(\"haha\");\n\t\t\t}\n\t\t}\n\t}\n#Markdown Editor\nThis is a simple markdown editor based on `YYTextView`.\n\n*********************************************\nIt\'s *italic* style.\n\nIt\'s also _italic_ style.\n\nIt\'s **bold** style.\n\nIt\'s ***italic and bold*** style.\n\nIt\'s __underline__ style.\n\nIt\'s ~~deleteline~~ style.\n\n\nHere is a link: [YYKit](https://github.com/ibireme/YYKit)\n\nHere is some code:\n\n\tif(a){\n\t\tif(b){\n\t\t\tif(c){\n\t\t\t\tprintf(\"haha\");\n\t\t\t}\n\t\t}\n\t}\n";
        
        addYYTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addYYTextView() {
        let markdownParser = YYTextSimpleMarkdownParser()
        markdownParser.setColorWithDarkTheme()
        
        let textView = YYTextView(frame: view.frame)
        textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
//        textView.scrollIndicatorInsets = textView.contentInset
//        textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        textView.backgroundColor = UIColor(white: 0.134, alpha: 1.0)
        textView.font = UIFont.systemFontOfSize(30)
        textView.textParser = markdownParser
        textView.delegate = self
        
        textView.text = text
        view.addSubview(textView)
    }

}
