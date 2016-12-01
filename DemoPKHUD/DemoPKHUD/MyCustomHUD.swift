//
//  MyCustomHUD.swift
//  DemoPKHUD
//
//  Created by Chris Hu on 16/11/29.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import Foundation
import MBProgressHUD

class MyCustomHUD {
    
}

extension MyCustomHUD {

    static func toastWithText(_ text: String) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        let hud = MBProgressHUD.showAdded(to: keyWindow, animated: true)
        hud.mode = .text
        hud.label.text = text
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1.0)
    }
    
    static func toastWithLongText(_ text: String) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        let hud = MBProgressHUD.showAdded(to: keyWindow, animated: true)
        hud.mode = .text
        hud.detailsLabel.text = text
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 1.0)
    }

}

extension MyCustomHUD {
    
    static func execute(_ executionClosure: @escaping () -> Void, executionText: String?, finishText: String?) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        let hud = MBProgressHUD.showAdded(to: keyWindow, animated: true)
        hud.mode = .indeterminate
        hud.label.text = executionText
        hud.removeFromSuperViewOnHide = true
        
        DispatchQueue.global().async {
            
            executionClosure()
            
            DispatchQueue.main.async {
                hud.hide(animated: true)
                
                if let finishText = finishText {
                    toastWithText(finishText)
                }
            }
        }
    }
    
    static func execute(_ executionClosure: @escaping () -> Void, executionText: String?, finishLongText: String?) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        let hud = MBProgressHUD.showAdded(to: keyWindow, animated: true)
        hud.mode = .indeterminate
        hud.label.text = executionText
        hud.removeFromSuperViewOnHide = true
        
        DispatchQueue.global().async {
            
            executionClosure()
            
            DispatchQueue.main.async {
                hud.hide(animated: true)
                
                if let finishLongText = finishLongText {
                    toastWithLongText(finishLongText)
                }
            }
        }
    }
}
