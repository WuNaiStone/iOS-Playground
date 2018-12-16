//
//  MVPPresenter.swift
//  DemoMVP
//
//  Created by icetime17 on 2018/12/16.
//  Copyright © 2018 com.icetime. All rights reserved.
//

import UIKit

protocol MVPPresentable {
    func present()
}

class MVPPresenter {
    var lbName: UILabel?
    var lbAge: UILabel?
    var lbCity: UILabel?
    
    var mvpModel: MVPModel?
}

extension MVPPresenter: MVPPresentable {
    func present() {
        guard let mvpModel = mvpModel else { return }
        
        lbName?.text = mvpModel.name
        if let age = mvpModel.age {
            lbAge?.text = "\(age)"
        }
        lbCity?.text = mvpModel.city
    }
}
