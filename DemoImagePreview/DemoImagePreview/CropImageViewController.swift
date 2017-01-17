//
//  CropImageViewController.swift
//  DemoImagePreview
//
//  Created by Chris Hu on 17/1/17.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

private let offset: CGFloat = 10.0

class CropImageViewController: UIViewController {

    var topBar: UIView!
    var btnRight: UIButton!
    
    var cropImageView: CropImageView!
    var ratioView: UIView!              // 裁剪框
    
    var imageOriginal: UIImage!         // 原图
    var imageCropped: UIImage!          // 裁剪结果图
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        imageOriginal = UIImage(named: "Model.png")
        
        initTopBar()
        
        initCropImageView()
        
        initRatioView()
    }

    // MARK: - topBar
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
    
    func initCropImageView() {
        let height = view.frame.height - topBar.frame.height - 250 - offset * 3
        
        cropImageView = CropImageView(frame: CGRect(x: 0, y: topBar.frame.height + offset, width: view.frame.width, height: height))
        view.addSubview(cropImageView)
        cropImageView.originImage = imageOriginal
    }
    
    func initRatioView() {
        let height = cropImageView.frame.height + 4
        let width = CGFloat(height / 16 * 9)
        ratioView = UIView(frame: CGRect(x: (view.frame.width - width) / 2, y: topBar.frame.height + offset - 2, width: width, height: height))
        ratioView.layer.borderColor = UIColor.yellow.cgColor
        ratioView.layer.borderWidth = 1
        ratioView.center = cropImageView.center
        view.addSubview(ratioView)
        ratioView.isUserInteractionEnabled = false
    }
    
}

extension CropImageViewController {
    
    func cropImage() -> UIImage? {
        let scaleImage = imageOriginal.size.height / cropImageView.frame.height
        // 注意2的offset
        let ratioRect = CGRect(x: ratioView.frame.origin.x,
                               y: ratioView.frame.origin.y + 2,
                               width: ratioView.frame.width,
                               height: ratioView.frame.height - 4)
        // 注意convert的写法, 以view的坐标系为参考
        var rect = view.convert(ratioRect, to: cropImageView)
        rect = CGRect(x: rect.origin.x * scaleImage / cropImageView.imageScale,
                      y: rect.origin.y * scaleImage / cropImageView.imageScale,
                      width: rect.width * scaleImage / cropImageView.imageScale,
                      height: rect.height * scaleImage / cropImageView.imageScale)
        
        let image = imageOriginal.imageCropped(bounds: rect)
        return image
    }
    
}

private extension UIImage {
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

