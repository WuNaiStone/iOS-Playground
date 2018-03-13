//
//  ViewController.swift
//  DemoMVP
//
//  Created by Chris Hu on 13/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

import UIKit

// MARK: - Model

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

// MARK: - Presenter

// Presenter用于View和Model, View自身暴露一个指定方法用于更新UI.
// Presenter拥有Model
class Presenter {
    // object need to and can be presented (such as model object)
    let presentable: Presentable
    
    required init(presentable: Presentable) {
        self.presentable = presentable
    }
    
    var presentInfo: String {
        return "\(presentable.name), \(presentable.age), \(presentable.addtionalInfo)"
    }
}

// MARK: - View

// object to present something (such as UIView)
protocol PresenterDelegate: class {
    func present()
}

// View拥有Presenter
class MyView: UIView, PresenterDelegate {
    var presenter: Presenter!
    
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
    
    func present() {
        self.lbInfo.text = presenter.presentInfo
    }
}

// MARK: - 使用

class ViewController: UIViewController {
    var myView: MyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView = MyView(frame: self.view.frame)
        view.addSubview(myView)
        
        let user = User(name: "Chris", age: 18, city: "Shanghai")
        let presenter = Presenter(presentable: user)
        myView.presenter = presenter
        myView.present()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let dog = Dog(name: "Doggee", age: 2, owner: "Chris")
            let presenter = Presenter(presentable: dog)
            self.myView.presenter = presenter
            self.myView.present()
        }
    }
}

