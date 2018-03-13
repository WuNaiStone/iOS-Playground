//
//  ViewController.swift
//  DemoMVP
//
//  Created by Chris Hu on 13/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

import UIKit

protocol Presentable {
    var name: String { get }
    var age: Int { get }
    
    var addtionalInfo: String { get }
}

struct User: Presentable {
    var name: String
    var age: Int
    
    var addtionalInfo: String {
        return city
    }
    
    let city: String
}

struct Dog: Presentable {
    var name: String
    var age: Int
    
    var addtionalInfo: String {
        return owner
    }
    
    let owner: String
}

// Presenter接收view和model, 暴露一个指定方法用于设置view.

protocol PresenterDelegate: class {
    func present(info: String)
}

class Presenter {
    let presentable: Presentable // object need to and can be presented (such as model object)
    let presenter: PresenterDelegate // object to present something (such as UIView)
    
    required init(presentable: Presentable, presenter: PresenterDelegate) {
        self.presentable = presentable
        self.presenter = presenter
    }
    
    func present() {
        let info = "\(presentable.name), \(presentable.age), \(presentable.addtionalInfo)"
        self.presenter.present(info: info)
    }
}

class MyView: UIView, PresenterDelegate {
    var lbInfo: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black
        
        self.lbInfo = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        self.lbInfo.font = UIFont.systemFont(ofSize: 20)
        self.lbInfo.textColor = UIColor.white
        self.addSubview(self.lbInfo)
        self.lbInfo.center = self.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func present(info: String) {
        self.lbInfo.text = info
    }
}

class ViewController: UIViewController {
    var presenter: Presenter!
    var myView: MyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView = MyView(frame: self.view.frame)
        view.addSubview(myView)
        
        let user = User(name: "Chris", age: 18, city: "Shanghai")
        presenter = Presenter(presentable: user, presenter: myView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.present()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let dog = Dog(name: "Doggee", age: 2, owner: "Chris")
            self.presenter = Presenter(presentable: dog, presenter: self.myView)
            self.presenter.present()
        }
    }
}

