//
//  LoginViewController.swift
//  DemoRxSwift
//
//  Created by Chris Hu on 17/1/19.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


let minUsernameLength = 3
let maxUsernameLength = 5

let minPasswdLength = 3
let maxPasswdLength = 5


class LoginViewController: UIViewController {

    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var lbUsernameInfo: UILabel!
    
    @IBOutlet weak var textFieldPasswd: UITextField!
    @IBOutlet weak var lbPasswdInfo: UILabel!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    var disposeBag = DisposeBag()
    
    
    var indicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 声明Observable，可观察对象
        let userValidation = textFieldUsername.rx.text.orEmpty
            .map { (user) -> Bool in
                let length = user.characters.count
                return length >= minUsernameLength && length <= maxUsernameLength
            }
        .shareReplay(1)
        
        let passwdValidataion = textFieldPasswd.rx.text.orEmpty
            .map{ (passwd) -> Bool in
                let length = passwd.characters.count
                return length >= minUsernameLength && length <= maxUsernameLength
            }
            .shareReplay(1)
        
        // 声明Observable
        let loginValidation = Observable.combineLatest(userValidation, passwdValidataion) {
            $0 && $1
        }.shareReplay(1)
        
        
        // bind，即将Observable与Observer绑定，最终也会调用subscribe
        // 此处是将isEnabled视为一个Observer，接收userValidation的消息，做出响应
        // 所以Observable发送的消息与Observer能接收的消息要对应起来（此处是Bool）
        userValidation
            .bindTo(textFieldPasswd.rx.isEnabled)
            .addDisposableTo(disposeBag)
        userValidation
            .bindTo(lbUsernameInfo.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        passwdValidataion
            .bindTo(lbPasswdInfo.rx.isHidden)
            .addDisposableTo(disposeBag)
        
        loginValidation
            .bindTo(btnLogin.rx.isEnabled)
            .addDisposableTo(disposeBag)
        
        
        // 将tap操作视为一个Observable，添加一些对应的响应操作（订阅），一旦tap执行（即发送消息），则会执行对应的响应代码
        btnLogin.rx.tap
            .subscribe(
                onNext: { [weak self] in
                    print("onNext")
                    self?.login()
                },
                onCompleted: { [weak self] in
                    print("onCompleted")
                    print(self!)
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    func login() {
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.addSubview(indicatorView)
        indicatorView.center = view.center
        
        indicatorView.startAnimating()
        
        DispatchQueue.global().async {
            
            for _ in 0...5 {
                sleep(1)
            }
            
            DispatchQueue.main.async {
                print("Done")
                self.indicatorView.stopAnimating()
            }
        }
    }

}
