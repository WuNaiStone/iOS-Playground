//
//  MyZoomScrollView.swift
//  DemoImagePreview
//
//  Created by Chris Hu on 17/1/9.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit

class MyZoomScrollView: UIView {

    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    fileprivate var imageView: UIImageView!
    fileprivate var scrollView: UIScrollView!
    
    // 双击放大的手势
    fileprivate var tapGesture: UITapGestureRecognizer!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initScrollView()
        
        initImageView()
        
        initTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initScrollView() {
        scrollView = UIScrollView(frame: bounds)
        addSubview(scrollView)
        
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    private func initImageView() {
        imageView = UIImageView(frame: bounds)
        scrollView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
    }
    
    private func initTapGesture() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(MyZoomScrollView.actionTapGesture(_:)))
        tapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func actionTapGesture(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self)
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            let rect = zoomRectWithPoint(point: touchPoint, tScale: scrollView.maximumZoomScale)
            scrollView.zoom(to: rect, animated: true)
        }
    }
    
    // 双击放大的区域
    @objc private func zoomRectWithPoint(point: CGPoint, tScale: CGFloat) -> CGRect {
        var width = frame.width / tScale
        var height = frame.height / tScale
        
        let ox = point.x - width / 2
        let oy = point.y - height / 2
        
        // 计算偏移量
        var showSize = CGSize.zero
        showSize.width = min(frame.width, scrollView.frame.width)
        showSize.height = min(frame.height, scrollView.frame.height)
        
        let scale = showSize.width / showSize.height
        
        if width / height > scale {
            width = height * scale
        } else {
            height = width / scale
        }
        
        return CGRect(x: ox, y: oy, width: width, height: height)
    }
    
}

extension MyZoomScrollView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // imageView
        let imageView = scrollView.subviews.first as! UIImageView
        
        let offsetX = max((scrollView.frame.width - scrollView.contentSize.width) * 0.5, 0.0)
        let offsetY = max((scrollView.frame.height - scrollView.contentSize.height) * 0.5, 0.0)
        
        imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                                   y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    
}

