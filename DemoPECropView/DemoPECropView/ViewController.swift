//
//  ViewController.swift
//  DemoPECropView
//
//  Created by Chris Hu on 17/1/18.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cropView: PECropView!
    
    @IBOutlet weak var btnCrop: UIButton!
    @IBAction func actionCrop(_ sender: UIButton) {
        guard let croppedImage = cropView.croppedImage else { return }
        print(croppedImage.size)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cropView = PECropView(frame: CGRect(x: 0, y: btnCrop.frame.maxY + 50, width: view.frame.width, height: 400))
        cropView.clipsToBounds = true
        cropView.backgroundColor = UIColor.red
        view.insertSubview(cropView, at: 0)
        
        cropView.image = UIImage(named: "Model.jpg")
        cropView.rotationGestureRecognizer.isEnabled = true
        
        cropView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let ratio = 16.0 / 9.0
        var cropRect = cropView.cropRect
        let height = cropRect.height
        cropRect.size = CGSize(width: height / CGFloat(ratio), height: height)
        cropView.cropRect = cropRect
        
        cropView.keepingCropAspectRatio = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.cropView.isHidden = false
        }
        
    }

}

