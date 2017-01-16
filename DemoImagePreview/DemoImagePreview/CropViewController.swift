//
//  CropViewController.swift
//  DemoImagePreview
//
//  Created by Chris Hu on 17/1/13.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit


private let offset: CGFloat = 10.0

class CropViewController: UIViewController {
    
    var topBar: UIView!
    var btnRight: UIButton!
    
    var myZoomScrollView: MyZoomScrollView! // 原图的scrollView
    var cropMaskView: UIView!           // 裁剪的maskView
    var ratioView: UIView!              // 裁剪框
    
    var imageOriginal: UIImage!         // 原图
    var imageCropped: UIImage!          // 裁剪结果图
    
}

// MARK: - VC生命周期
extension CropViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        imageOriginal = UIImage(named: "Model.png")
        
        initTopBar()
        
        initMyZoomScrollView()
        
        initCropMaskView()
        
        initRatioView()
        
        maskClipping()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - topBar
extension CropViewController {
    func initTopBar() {
        topBar = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        topBar.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.addSubview(topBar)
        
        btnRight = UIButton(frame: CGRect(x: topBar.frame.width - 70, y: 0, width: 70, height: topBar.frame.height))
        btnRight.setTitle("裁剪", for: .normal)
        btnRight.addTarget(self, action: #selector(CropViewController.actionBtnRight), for: .touchUpInside)
        topBar.addSubview(btnRight)
    }
    
    func actionBtnRight() {
        // TODO 裁剪操作
        let image = cropImage()
        print(image?.size)
    }
    
}

extension CropViewController {
    
    func initMyZoomScrollView() {
        let height = view.frame.height - topBar.frame.height - 250 - offset * 3
        
        myZoomScrollView = MyZoomScrollView(frame: CGRect(x: 0, y: topBar.frame.height + offset, width: view.frame.width, height: height))
        view.addSubview(myZoomScrollView)
        myZoomScrollView.backgroundColor = UIColor.red
        myZoomScrollView.image = imageOriginal
    }
    
    func initCropMaskView() {
        cropMaskView = UIView(frame: view.bounds)
        cropMaskView.backgroundColor = UIColor.green
        cropMaskView.alpha = 0.2
        view.addSubview(cropMaskView)
        cropMaskView.isUserInteractionEnabled = false
    }
    
    func initRatioView() {
        let height = myZoomScrollView.frame.height + 4
        let width = CGFloat(height / 16 * 9)
        ratioView = UIView(frame: CGRect(x: (view.frame.width - width) / 2, y: topBar.frame.height + offset - 2, width: width, height: height))
        ratioView.layer.borderColor = UIColor.yellow.cgColor
        ratioView.layer.borderWidth = 1
        ratioView.center = myZoomScrollView.center
        view.addSubview(ratioView)
        ratioView.isUserInteractionEnabled = false
    }
    
    func maskClipping() {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        let left = CGRect(x: 0, y: 0, width: ratioView.frame.minX, height: cropMaskView.frame.height)
        let right = CGRect(x: ratioView.frame.maxX, y: 0, width: cropMaskView.frame.width - ratioView.frame.maxX, height: cropMaskView.frame.height)
        let top = CGRect(x: 0, y: 0, width: cropMaskView.frame.width, height: ratioView.frame.minY)
        let bottom = CGRect(x: 0, y: ratioView.frame.maxY, width: cropMaskView.frame.size.width, height: cropMaskView.frame.height - ratioView.frame.maxY)
        path.addRects([left, right, top, bottom])
        maskLayer.path = path
        cropMaskView.layer.mask = maskLayer
    }
    
}

extension CropViewController {
    
    func cropImage() -> UIImage? {
        return imageOriginal
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

