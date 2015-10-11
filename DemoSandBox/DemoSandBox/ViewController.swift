//
//  ViewController.swift
//  DemoSandBox
//
//  Created by zj－db0465 on 15/10/10.
//  Copyright © 2015年 icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var infos: NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn: UIButton = UIButton(frame: CGRectMake(0, 100, self.view.frame.width, 50))
        btn.setTitle("demoSandBox", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted)
        btn.layer.borderColor = UIColor.blueColor().CGColor
        btn.layer.borderWidth = 2.0
        btn.addTarget(self, action: "demoSandBox", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
        let btn1: UIButton = UIButton(frame: CGRectMake(0, 200, self.view.frame.width, 50))
        btn1.setTitle("demoNSBundle", forState: UIControlState.Normal)
        btn1.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btn1.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted)
        btn1.layer.borderColor = UIColor.blueColor().CGColor
        btn1.layer.borderWidth = 2.0
        btn1.addTarget(self, action: "demoNSBundle", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn1)
        
        let btn2: UIButton = UIButton(frame: CGRectMake(0, 300, self.view.frame.width, 50))
        btn2.setTitle("demoReadWrite", forState: UIControlState.Normal)
        btn2.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btn2.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted)
        btn2.layer.borderColor = UIColor.blueColor().CGColor
        btn2.layer.borderWidth = 2.0
        btn2.addTarget(self, action: "demoReadWrite", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn2)
        
        let btn3: UIButton = UIButton(frame: CGRectMake(0, 400, self.view.frame.width, 50))
        btn3.setTitle("demoReadImage", forState: UIControlState.Normal)
        btn3.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btn3.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted)
        btn3.layer.borderColor = UIColor.blueColor().CGColor
        btn3.layer.borderWidth = 2.0
        btn3.addTarget(self, action: "demoReadImage", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func demoSandBox() {
        // 使用NSHomeDirectory
        let home: String = NSHomeDirectory()
        print("home : \(home)")
        
        var documentsPath: String = home.stringByAppendingString("/Documents")
        print("documents : \(documentsPath)")
        
        // 使用NSSearchPathForDirectoriesInDomains比NSHomeDirectory更安全。
        let paths: [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        print("paths : \(paths)")
        documentsPath = paths[0]
        print("documents : \(documentsPath)")
        
        let library: String = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0]
        print("library : \(library)")
        
        let preferencs: String = NSSearchPathForDirectoriesInDomains(.PreferencePanesDirectory, .UserDomainMask, true)[0]
        print("preferencs : \(preferencs)")
        
        let caches: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
        print("caches : \(caches)")
    }
    
    func demoNSBundle() {
        let infoPath: String = NSBundle.mainBundle().pathForResource("Info", ofType: "plist") as String!
        print(infoPath)
        infos = NSMutableDictionary(contentsOfFile: infoPath) as NSMutableDictionary!
        print(infos)
        let bundleName: String = infos["CFBundleName"] as! String
        print(bundleName)
        
        let docPath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let filePath: String = docPath.stringByAppendingString("/Info.plist")
        print(filePath)
        infos["CFBundleName"] = "DemoSandBox testing"
        infos.writeToFile(filePath, atomically: true)
        
        var nibs: [AnyObject] = NSBundle.mainBundle().loadNibNamed("testNib", owner: nil, options: nil)
        var testNib: UIView = nibs.last as! UIView
    }
    
    func demoReadWrite() {
        let docPath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let filePath: String = docPath.stringByAppendingString("/filename")
        print(filePath)
        
        var data = NSMutableData()
        data.appendData("testing content".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        data.writeToFile(filePath, atomically: true)
        var array = NSArray(contentsOfFile: filePath)
        var dict = NSDictionary(contentsOfFile: filePath)
        var content = String(data: NSData(contentsOfFile: filePath)!, encoding: NSUTF8StringEncoding)!
        print(content)

        do {
            //Error Domain=NSCocoaErrorDomain Code=514 "The item couldn’t be saved because the file name “” is invalid." UserInfo={NSFilePath=}
            try "testing content again".writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
            
            try content = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
            print(content)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func demoReadImage() {
        var imagePath: String = NSBundle.mainBundle().pathForResource("Image", ofType: "jpg") as String!
        var image: UIImage = UIImage(contentsOfFile: imagePath)!
        
        var data: NSData = NSData(contentsOfFile: imagePath)!
        image = UIImage(data: data)!
        
        // 读取网络图片
        var url: NSURL = NSURL(string: "http://imgphoto.gmw.cn/attachement/jpg/site2/20151010/eca86bd9dc471782b9ff28.jpg")!
        data = NSData(contentsOfURL: url)!
        image = UIImage(data: data)!
        
        // 将图片写入文件
        let docPath: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        imagePath = docPath.stringByAppendingString("/testImage.jpg")
        data.writeToFile(imagePath, atomically: true)
        image = UIImage(contentsOfFile: imagePath)!
        
        data = NSData(data: UIImagePNGRepresentation(image)!)
        // UIImageJPEGRepresentation(image, 1.0) // JPEG比PNG格式压缩更多
        var imagePath2: String = docPath.stringByAppendingString("/testImage2.png")
        data.writeToFile(imagePath2, atomically: true)
        image = UIImage(contentsOfFile: imagePath2)!
    }
    
}

