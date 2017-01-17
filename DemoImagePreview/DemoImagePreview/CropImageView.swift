//
//  CropImageView.swift
//  DemoImagePreview
//
//  Created by Chris Hu on 17/1/17.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class CropImageView: UIView {

    var originImage: UIImage! {
        didSet {
            imageView.image = originImage
        }
    }
    var croppedImage: UIImage!
    
    
    fileprivate var imageView: UIImageView!
    fileprivate var panGesture: UIPanGestureRecognizer!
    fileprivate var pinchGesture: UIPinchGestureRecognizer!
    fileprivate var rotationGesture: UIRotationGestureRecognizer!
    
    var minFrame: CGRect!    // 图片缩放的极限值
    var maxFrame: CGRect!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        backgroundColor = UIColor.red
        
        initImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initImageView() {
        minFrame = bounds
        maxFrame = CGRect(x: -minFrame.width, y: -minFrame.height, width: minFrame.width * 3, height: minFrame.height * 3)
        
        imageView = UIImageView(frame: bounds)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        panGesture = UIPanGestureRecognizer(target: self, action: .actionPanGesture)
        imageView.addGestureRecognizer(panGesture)
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: .actionPinchGesture)
        imageView.addGestureRecognizer(pinchGesture)
        
        rotationGesture = UIRotationGestureRecognizer(target: self, action: .actionRotationGesture)
//        imageView.addGestureRecognizer(rotationGesture)
        
//        panGesture.require(toFail: pinchGesture)
//        panGesture.require(toFail: rotationGesture)
    }
    
}

// MARK: - 手势操作
private extension Selector {
    static let actionPanGesture = #selector(CropImageView.actionPanGesture(_:))
    static let actionPinchGesture = #selector(CropImageView.actionPinchGesture(_:))
    static let actionRotationGesture = #selector(CropImageView.actionRotationGesture(_:))
}

private var lastPanPoint = CGPoint.zero
private var lastScale = CGFloat(1.0)
private var lastRotation = CGFloat(0.0)

extension CropImageView {
    
    private func finalAdjustImageView() {
        // 平移的极限值
        let offsetY = imageView.frame.height - frame.height
        if imageView.frame.minY < -offsetY {
            imageView.frame.origin.y = -offsetY
        }
        if imageView.frame.maxY > frame.height + offsetY {
            imageView.frame.origin.y = 0
        }
    }
    
    @objc fileprivate func actionPanGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            lastPanPoint = CGPoint.zero
        }
        
        let panPoint = sender.translation(in: self)
        
        let transform = CGAffineTransform(translationX: panPoint.x - lastPanPoint.x, y: panPoint.y - lastPanPoint.y)
        imageView.transform = imageView.transform.concatenating(transform)
        
        lastPanPoint = panPoint
        
        finalAdjustImageView()
    }
    
    @objc fileprivate func actionPinchGesture(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            lastScale = 1.0
            return
        }
        
        let scale = sender.scale / lastScale
        let currentTransform = imageView.transform
        let newTransform = currentTransform.scaledBy(x: scale, y: scale)
        imageView.transform = newTransform
        lastScale = sender.scale
        
        // 缩放的极限值
        if sender.state == .ended {
            if imageView.frame.height < minFrame.height {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.imageView.frame = self.minFrame
                })
            }
            if imageView.frame.height > maxFrame.height {
                UIView.animate(withDuration: 0.3, animations: {
                    self.imageView.frame = self.maxFrame
                })
            }
            
            finalAdjustImageView()
        }
    }
    
    @objc fileprivate func actionRotationGesture(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .ended {
            lastRotation = 0.0
            return
        }
        
        var rotation = sender.rotation - lastRotation
        let currentTransform = imageView.transform
        let newTransform = currentTransform.rotated(by: rotation)
        imageView.transform = newTransform
        
        lastRotation = sender.rotation
    }
}

