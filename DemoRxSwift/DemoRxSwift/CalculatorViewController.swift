//
//  CalculatorViewController.swift
//  DemoRxSwift
//
//  Created by Chris Hu on 17/1/20.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class CalculatorViewController: UIViewController {

    @IBOutlet weak var number1: UITextField!
    
    @IBOutlet weak var number2: UITextField!
    
    
    @IBOutlet weak var result: UILabel!
    
    
    @IBOutlet weak var btnClose: UIButton!
    
    
    deinit {
        print("deinit: \(self.description)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnClose.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .addDisposableTo(CS_DisposeBag)
        
        
        
        // 将number1，number2绑定到一起，构成一个Observable
        Observable.combineLatest(number1.rx.text, number2.rx.text) { (num1, num2) -> Int in
            if let num1 = num1, num1 != "", let num2 = num2, num2 != "" {
                return Int(num1)! + Int(num2)!
            } else {
                return 0
            }
        }
        // Observable发送的消息为Int，不能与text绑定，所以使用map进行加工
        .map { $0.description }
        // Obsever为result的text
        .bindTo(result.rx.text)
        .addDisposableTo(CS_DisposeBag)
        
    }
    
}
