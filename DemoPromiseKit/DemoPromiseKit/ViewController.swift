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


enum AuthorizationError: Error {
    case cameraNotAuthorized
    case photosNotAuthorized
    case locationNotAuthorized
}

extension ViewController {
    func actionPromise() {

        
/*
        PHPhotoLibrary.requestAuthorization().then { (status) -> Void in
            print(status)  // => true or false
        }
*/
        
        
        // http://promisekit.org/docs/
        
        /*
        PHPhotoLibrary.requestAuthorization().then { (authorized) -> Void in
            guard authorized == .authorized else { throw AuthorizationError.photosNotAuthorized }
        }.catch { (error) in
            print(error)
        }
        */
        
        
        
        PHPhotoLibrary.requestAuthorization().then { (authorized) -> Promise<CLLocation> in
            
            guard authorized == .authorized else { throw AuthorizationError.photosNotAuthorized }
            
            // returning a promise in a `then` handler waits on that
            // promise before continuing to the next handler
            return CLLocationManager.promise(.always)
            
            // if the above promise fails, execution jumps to the catch below
            
        }.then { (location) -> Void in
            
            // if anything throws in this handler execution also jumps to the `catch`
            print(location)
            
        }.catch { (error) in
            switch error {
            case AuthorizationError.cameraNotAuthorized:
                print("camera")
            case AuthorizationError.photosNotAuthorized:
                print("photos")
            case AuthorizationError.locationNotAuthorized:
                print("location")
            default:
                print("location : \(error)")
            }
        }
        
 
    }
}

