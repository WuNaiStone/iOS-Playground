//
//  ViewController.swift
//  DemoPromiseKit
//
//  Created by Chris Hu on 16/12/21.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import Photos
import CoreLocation

import PromiseKit

class ViewController: UIViewController {

    @IBAction func actionBtnPromise(_ sender: UIButton) { actionPromise() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    func actionPromise() {
        
        PHPhotoLibrary.requestAuthorization().then { status in
            print(status)  // => true or false
        }
        
        
        
        /*
         http://promisekit.org/docs/
         
         PHPhotoLibrary.requestAuthorization().then { authorized -> Void in
         guard authorized else { throw MyError.unauthorized }
         // …
         }.catch { error in
         UIAlertView(/*…*/).show()
         }
 */
        
        /*
         PHPhotoLibrary.requestAuthorization().then { authorized -> Promise in
         
         guard authorized else { throw MyError.unauthorized }
         
         // returning a promise in a `then` handler waits on that
         // promise before continuing to the next handler
         return CLLocationManager.promise()
         
         // if the above promise fails, execution jumps to the catch below
         
         }.then { location -> Void in
         
         // if anything throws in this handler execution also jumps to the `catch`
         
         }.catch { error in
         switch error {
         case MyError.unauthorized:
         //…
         case is CLError:
         //…
         }
         }
 */
    }
}

