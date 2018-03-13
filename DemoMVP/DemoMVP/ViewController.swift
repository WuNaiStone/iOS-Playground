//
//  ViewController.swift
//  DemoMVP
//
//  Created by Chris Hu on 13/03/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let age: Int
    let city: String
}

// Presenter接收view和model, 暴露一个指定方法用于设置view.

protocol UserPresenterDelegate: class {
    func showUserInfo(info: String)
}

class UserPresenter {
    let user: User
    let presenter: UserPresenterDelegate
    
    required init(user: User, presenter: UserPresenterDelegate) {
        self.user = user
        self.presenter = presenter
    }
    
    func showUserInfo() {
        let info = "\(user.name), \(user.age), \(user.city)"
        self.presenter.showUserInfo(info: info)
    }
}

class MyView: UIView, UserPresenterDelegate {
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
    
    func showUserInfo(info: String) {
        self.lbInfo.text = info
    }
}

class ViewController: UIViewController {
    var userPresenter: UserPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = MyView(frame: self.view.frame)
        self.view.addSubview(myView)
        
        let user = User(name: "Chris", age: 18, city: "Shanghai")
        self.userPresenter = UserPresenter(user: user, presenter: myView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.userPresenter.showUserInfo()
    }
}

