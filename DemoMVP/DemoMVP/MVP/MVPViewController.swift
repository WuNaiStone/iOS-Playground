//
//  MVPViewController.swift
//  DemoMVP
//
//  Created by icetime17 on 2018/12/16.
//  Copyright © 2018 com.icetime. All rights reserved.
//

import UIKit

// 这里，View直接放在VC中，不需要单独建立一个View的类
class MVPViewController: UIViewController {
    
    lazy var lbName: UILabel = {
        let x: CGFloat = 20
        let y: CGFloat = 100
        let width: CGFloat = self.view.frame.width - x * 2
        let height: CGFloat = 54
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let v = UILabel(frame: frame)
        v.text = "initial name"
        v.textColor = UIColor.black
        v.textAlignment = .left
        v.numberOfLines = 0
        v.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return v
    }()
    lazy var lbAge: UILabel = {
        let x: CGFloat = 20
        let y: CGFloat = 200
        let width: CGFloat = self.view.frame.width - x * 2
        let height: CGFloat = 54
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let v = UILabel(frame: frame)
        v.text = "initial age"
        v.textColor = UIColor.black
        v.textAlignment = .left
        v.numberOfLines = 0
        v.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return v
    }()
    lazy var lbCity: UILabel = {
        let x: CGFloat = 20
        let y: CGFloat = 300
        let width: CGFloat = self.view.frame.width - x * 2
        let height: CGFloat = 54
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let v = UILabel(frame: frame)
        v.text = "initial city"
        v.textColor = UIColor.black
        v.textAlignment = .left
        v.numberOfLines = 0
        v.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return v
    }()
    
    
    var mvpPresenter = MVPPresenter()
    var mvpModel: MVPModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        setupMVP()
    }
}

extension MVPViewController {
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(lbName)
        view.addSubview(lbAge)
        view.addSubview(lbCity)
    }
    
    /*
        Presenter会持有View和Model，然后暴露一个业务接口，在VC中调用。
        可见：MVP的可测试性不强，不如MVVM。
     */
    func setupMVP() {
        mvpPresenter.lbName = lbName
        mvpPresenter.lbAge = lbAge
        mvpPresenter.lbCity = lbCity
        
        mvpModel = MVPModel(name: "Chris", age: 18, city: "Shanghai")
        mvpPresenter.mvpModel = mvpModel
        
        mvpPresenter.present()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mvpModel = MVPModel(name: "Chris Again", age: 18, city: "Shanghai Again")
            self.mvpPresenter.mvpModel = self.mvpModel
            
            self.mvpPresenter.present()
        }
    }
}
