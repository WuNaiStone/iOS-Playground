//
//  VideoCameraViewController.swift
//  DemoVideoCapture
//
//  Created by Chris Hu on 17/1/9.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import GPUImage

class VideoCameraViewController: UIViewController {
    
    var videoPreview: GPUImageView!
    var videoCamera: GPUImageVideoCamera!
    var currentFilter: GPUImageFilter!
    var isVideoCapturing = false
    var movieWriter: GPUImageMovieWriter!
    var videoPath: String!
    
    
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var btnRotate: UIButton!
    @IBAction func actionBtnRotate(_ sender: UIButton) { actionRotate() }
    var videoDuration: CSViewVideoCameraDuration!
    
    @IBOutlet weak var toolBar: UIView!
    @IBAction func actionBtnCapture(_ sender: UIButton) { actionCapture() }
    
}

// MARK: - VC生命周期
extension VideoCameraViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVideoCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        videoCamera.startCapture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool { return true }
}

extension VideoCameraViewController {
    func initVideoCamera() {
        videoPreview = GPUImageView(frame: view.frame)
        videoPreview.backgroundColor = UIColor.black
        videoPreview.fillMode = kGPUImageFillModePreserveAspectRatio
        view.insertSubview(videoPreview, at: 0)
        
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset1920x1080, cameraPosition: .back)
        videoCamera.outputImageOrientation = .portrait
        videoCamera.horizontallyMirrorRearFacingCamera = false
        videoCamera.horizontallyMirrorFrontFacingCamera = true
        videoCamera.delegate = self
        
        currentFilter = GPUImageFilter()
        videoCamera.addTarget(currentFilter)
        currentFilter.addTarget(videoPreview)
    }
    
    func initMovieWriter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd h:m:s"
        let videoName = dateFormatter.string(from: Date())
        
        videoPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        videoPath.append("/\(videoName).mp4")
        print("videoPath : \(videoPath)")
        
        let movieURL = URL(fileURLWithPath: videoPath)
        
        movieWriter = GPUImageMovieWriter(movieURL: movieURL, size: CGSize(width: 1080, height: 1920))
        movieWriter.encodingLiveVideo = true
        
        currentFilter.addTarget(movieWriter)
        
        videoCamera.audioEncodingTarget = movieWriter
        movieWriter.shouldPassthroughAudio = true
    }
    
    func actionCapture() {
        if videoDuration == nil {
            videoDuration = CSViewVideoCameraDuration(frame: topBar.frame)
            topBar.insertSubview(videoDuration, at: 0)
        }
        
        isVideoCapturing = !isVideoCapturing
        if isVideoCapturing {
            videoDuration.startVideoCapture()
            
            if movieWriter == nil {
                initMovieWriter()
            }
            movieWriter.startRecording()
        } else {
            videoDuration.stopVideoCapture()
            
            if movieWriter != nil {
                movieWriter.finishRecording()
                currentFilter.removeTarget(movieWriter)
                movieWriter = nil
                
                performSegue(withIdentifier: "segueVideoCaptureDone", sender: nil)
            }
        }
    }
    
    func actionRotate() {
        videoCamera.rotateCamera()
    }
}

extension VideoCameraViewController: GPUImageVideoCameraDelegate {
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        
    }
}

extension VideoCameraViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if FileManager.default.fileExists(atPath: videoPath) {
            let videpPlayVC = segue.destination as! VideoPlayViewController
            videpPlayVC.videoPath = videoPath
        }
    }
}
