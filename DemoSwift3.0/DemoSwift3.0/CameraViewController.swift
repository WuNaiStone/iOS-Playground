//
//  ViewController.swift
//  DemoSwift3.0
//
//  Created by Chris Hu on 16/11/11.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit
import GPUImage

let kDTSScreenWidth     = UIScreen.main.bounds.width
let kDTSScreenHeight    = UIScreen.main.bounds.height
let kDTSScreenSize      = UIScreen.main.bounds.size

class CameraViewController: UIViewController {
    
    var stillCamera: GPUImageStillCamera!
    var previewView: GPUImageView!
    var currentFilter: GPUImageFilter!
    var filterGroup: GPUImageFilterGroup!
    
    // 拍照的黑屏mask
    var maskViewCapture: UIView!
    
    // 操作面板
    var btnCapture: UIButton!
    var btnRotate: UIButton!
    var btnFilter: UIButton!
    
    // 滤镜类型
    enum CameraFilterType {
        case None
        case Moonlight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCameraView()
        
        initOperationView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filterType = .Moonlight
        
        stillCamera.startCapture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initCameraView() {
        previewView = GPUImageView(frame: view.frame)
        previewView.backgroundColor = .black
        previewView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill
        view.insertSubview(previewView, at: 0)
        
        maskViewCapture = UIView(frame: previewView.bounds)
        view.addSubview(maskViewCapture)
        maskViewCapture.backgroundColor = .black
        maskViewCapture.isHidden = true
        
        stillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPresetPhoto, cameraPosition: AVCaptureDevicePosition.back)
        stillCamera.outputImageOrientation = UIInterfaceOrientation.portrait
        stillCamera.horizontallyMirrorFrontFacingCamera = true
        stillCamera.delegate = self
        
        // 默认focusPoint
        let focusPoint = CGPoint(x: 0.5, y: 0.5)
        do {
            try stillCamera.inputCamera.lockForConfiguration()
        } catch _ {
            print("lockForConfiguration failed.")
        }
        if (stillCamera.inputCamera.isFocusPointOfInterestSupported) {
            stillCamera.inputCamera.focusPointOfInterest = focusPoint;
            stillCamera.inputCamera.focusMode = .continuousAutoFocus
        }
        
        stillCamera.inputCamera.exposurePointOfInterest = focusPoint
        stillCamera.inputCamera.exposureMode = .continuousAutoExposure
        stillCamera.inputCamera.unlockForConfiguration()
    }
    
    
    // MARK - Filter
    var filterType: CameraFilterType {
        get {
            return self.filterType
        }
        set {
            if currentFilter != nil {
                stillCamera.removeTarget(currentFilter)
            }
            if filterGroup != nil {
                stillCamera.removeTarget(filterGroup)
            }
            
            switch newValue {
            case .None:
                currentFilter = GPUImageFilter()
                
                currentFilter.addTarget(previewView)
                stillCamera.addTarget(currentFilter)
            case .Moonlight:
//                filterGroup = GPUImageFilterGroup()
                
//                let lookupImageSource = GPUImagePicture(image: UIImage(named: "LUT_Moonlight.png"))
//                let lookupFilter = GPUImageLookupFilter()
//                
//                filterGroup.addFilter(lookupFilter)
//                
//                lookupImageSource?.addTarget(lookupFilter, atTextureLocation: 1)
//                lookupImageSource?.processImage()
//                
//                filterGroup.initialFilters = [lookupFilter]
//                filterGroup.terminalFilter = lookupFilter
                
//                filterGroup = GPUImageAmatorkaFilter()
                
//                filterGroup = MyFilter()
                
                filterGroup = MyFilter(LUTImage: UIImage(named: "LUT_Moonlight.png")!)
                
                filterGroup.addTarget(previewView)
                stillCamera.addTarget(filterGroup)
            }
        }
    }
    
    
}

extension CameraViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension CameraViewController {
    func initOperationView() {
        initBtnRotate()
        initBtnFilter()
        initBtnCapture()
    }
    
    func initBtnRotate() {
        btnRotate = UIButton(frame: CGRect(x: 20, y: kDTSScreenHeight - 100, width: 80, height: 50))
        btnRotate.backgroundColor = .lightGray
        btnRotate.setTitle("rotate", for: .normal)
        btnRotate.setTitleColor(.white, for: .normal)
        view.addSubview(btnRotate)
        btnRotate.addTarget(self, action: #selector(CameraViewController.actionBtnRotate), for: .touchUpInside)
    }
    
    func actionBtnRotate() {
        stillCamera.rotateCamera()
    }
    
    func initBtnFilter() {
        btnFilter = UIButton(frame: CGRect(x: kDTSScreenWidth - 100, y: kDTSScreenHeight - 100, width: 80, height: 50))
        btnFilter.backgroundColor = .lightGray
        btnFilter.setTitle("Filter", for: .normal)
        btnFilter.setTitleColor(.white, for: .normal)
        view.addSubview(btnFilter)
        btnFilter.addTarget(self, action: #selector(CameraViewController.actionBtnFilter), for: .touchUpInside)
    }
    
    func actionBtnFilter() {
        filterType = .Moonlight
    }
    
    // Capture
    func initBtnCapture() {
        btnCapture = UIButton(frame: CGRect(x: 0, y: kDTSScreenHeight - 100, width: 80, height: 50))
        btnCapture.backgroundColor = .lightGray
        btnCapture.setTitle("拍照", for: .normal)
        btnCapture.setTitleColor(.white, for: .normal)
        view.addSubview(btnCapture)
        btnCapture.center = view.center
        
        btnCapture.addTarget(self, action: #selector(CameraViewController.actionBtnCapture), for: .touchUpInside)
    }
    
    func actionBtnCapture() {
        btnCapture.isEnabled = false
        if !UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        
        // 拍照动画
        maskViewCapture.isHidden = false
        
        capturePhoto()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.maskViewCapture.isHidden = true
        }
    }
    
    func capturePhoto() {
        stillCamera.capturePhotoAsImageProcessedUp(toFilter: filterGroup, with: .up) { (image: UIImage?, error: Error?) in
            self.stillCamera.pauseCapture()
            
            if error == nil {
                self.stillCamera.resumeCameraCapture()
                
                var desImage: UIImage!
                DispatchQueue.global().async(execute: {
                    desImage = image
                    
                    DispatchQueue.main.async(execute: {
                        self.btnCapture.isEnabled = true
                        if UIApplication.shared.isIgnoringInteractionEvents {
                            UIApplication.shared.endIgnoringInteractionEvents()
                        }
                    })
                })
                
                DispatchQueue.global().async(execute: {
                    UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                })
            }
        }
    }
}

extension CameraViewController: GPUImageVideoCameraDelegate {
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        
    }
}


