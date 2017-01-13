//
//  CropViewController.swift
//  DemoImagePreview
//
//  Created by Chris Hu on 17/1/13.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class CropViewController: UIViewController {

    var imageView: UIImageView!
    var maskView: UIView!
    var ratioView: UIView!
    
    var imageOriginal: UIImage!    // 原图
    var imageCropped: UIImage!     // 裁剪结果图
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        imageOriginal = UIImage(named: "Model.png")
        
        initImageView()
        
        initCropMaskView()
        
        initRatioView()
        
        maskClipping()
    }

}

// MARK: - 裁剪操作
let height = CGFloat(300)
extension CropViewController {
    
    func initImageView() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: height))
        imageView.center = view.center
        imageView.image = imageOriginal
        view.insertSubview(imageView, at: 0)
        imageView.isUserInteractionEnabled = true
    }
    
    func initCropMaskView() {
        maskView = UIView(frame: view.bounds)
        view.addSubview(maskView)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.2
        maskView.center = view.center
        maskView.isUserInteractionEnabled = false
    }
    
    func initRatioView() {
        let height = 200
        let width = height / 16 * 9
        ratioView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        ratioView.layer.borderColor = UIColor.yellow.cgColor
        ratioView.layer.borderWidth = 1
        ratioView.center = imageView.center
        view.addSubview(ratioView)
        ratioView.isUserInteractionEnabled = false
    }
    
    func maskClipping() {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        let left = CGRect(x: 0, y: 0, width: ratioView.frame.minX, height: maskView.frame.height)
        let right = CGRect(x: ratioView.frame.maxX, y: 0, width: maskView.frame.width - ratioView.frame.maxX, height: maskView.frame.height)
        let top = CGRect(x: 0, y: 0, width: maskView.frame.width, height: ratioView.frame.minY)
        let bottom = CGRect(x: 0, y: ratioView.frame.maxY, width: maskView.frame.size.width, height: maskView.frame.height - ratioView.frame.maxY)
        path.addRects([left, right, top, bottom])
        maskLayer.path = path
        maskView.layer.mask = maskLayer;
    }
    
}

extension CropViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: view)
        imageView.center = touchPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: view)
        imageView.center = touchPoint
    }
}

extension UIImage {
    /**
     Crop UIImage
     
     - returns: UIImage cropped
     */
    func imageCropped(bounds: CGRect) -> UIImage {
        let imageRef = cgImage!.cropping(to: bounds)
        let imageCropped = UIImage(cgImage: imageRef!)
        return imageCropped
    }
}
