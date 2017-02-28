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
    
    @IBOutlet weak var btnClose: UIButton!
    
    
    deinit {
        print("deinit: \(self.description)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnClose.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.dismiss(animated: true, completion: nil)
            })
            .addDisposableTo(CS_DisposeBag)
        
        
        
        // 声明Observable，可观察对象
        // username的text没有太多参考意义，因此使用map来加工，得到是否可用的消息
        let userValidation = textFieldUsername.rx.text.orEmpty
            // map的参数是一个closure，接收element
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
        // 组合两个Observable
        let loginValidation = Observable.combineLatest(userValidation, passwdValidataion) {
                $0 && $1
            }
            .shareReplay(1)
        
        
        // bind，即将Observable与Observer绑定，最终也会调用subscribe
        // 此处是将isEnabled视为一个Observer，接收userValidation的消息，做出响应
        // 所以Observable发送的消息与Observer能接收的消息要对应起来（此处是Bool）
        userValidation
            .bindTo(textFieldPasswd.rx.isEnabled)
            .addDisposableTo(CS_DisposeBag)
        userValidation
            .bindTo(lbUsernameInfo.rx.isHidden)
            .addDisposableTo(CS_DisposeBag)
        
        passwdValidataion
            .bindTo(lbPasswdInfo.rx.isHidden)
            .addDisposableTo(CS_DisposeBag)
        
        loginValidation
            .bindTo(btnLogin.rx.isEnabled)
            .addDisposableTo(CS_DisposeBag)
        
        
        // 将tap操作视为一个Observable，添加一些对应的响应操作（订阅），一旦tap执行（即发送消息），则会执行对应的响应代码
        // 直接使用subscribe来指定响应操作即可，不需要map之类的加工
        btnLogin.rx.tap
            .subscribe(
                onNext: { [weak self] in
                    print("onNext")
                    guard let strongSelf = self else { return }
                    strongSelf.login()
                },
                onCompleted: { [weak self] in
                    print("onCompleted")
                    guard let strongSelf = self else { return }
                    print(strongSelf)
                }
            )
            .addDisposableTo(CS_DisposeBag)
    }
    
    func login() {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        view.addSubview(indicatorView)
        indicatorView.center = view.center
        
        indicatorView.startAnimating()
        
        DispatchQueue.global().async {
            
            for _ in 0...5 {
                sleep(1)
            }
            
            DispatchQueue.main.async {
                print("Done")
                indicatorView.stopAnimating()
            }
        }
    }

}
