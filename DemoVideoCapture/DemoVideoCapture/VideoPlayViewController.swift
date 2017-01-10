//
//  VideoPlayViewController.swift
//  DemoVideoCapture
//
//  Created by Chris Hu on 17/1/9.
//  Copyright © 2017年 com.icetime17. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayViewController: UIViewController {

    var videoPath = ""
    var avPlayerVC: AVPlayerViewController!
    var avPlayer: AVPlayer!
    
    var isVideoPlaying = false
    var isOperationShowing = true
    
    var videoURLString = ""
    
    @IBOutlet weak var btnBack: UIButton!
    @IBAction func actionBtnBack(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    // 拍摄的视频
    
    @IBOutlet weak var viewVideoCapture: UIView!
    @IBOutlet weak var btnPlayVideoCapture: UIButton!
    @IBAction func actionPlayVideoCapture(_ sender: UIButton) { actionPlayVideoCapture() }
    
    
    // 网络请求的视频
    @IBOutlet weak var viewVideoNetwork: UIView!
    @IBOutlet weak var viewVideoNetworkOperation: UIView!
    @IBOutlet weak var btnPlayVideoNetwork: UIButton!
    @IBAction func actionBtnPlayVideoNetwork(_ sender: UIButton) { actionPlayVideoNetwork() }
    
    @IBOutlet weak var btnNextVideoNetwork: UIButton!
    @IBAction func actionBtnNextVideoNetwork(_ sender: UIButton) { actionNextVideoNetwork() }
    
    @IBOutlet weak var btnLastVideoNetwork: UIButton!
    @IBAction func actionBtnLastVideoNetwork(_ sender: UIButton) { actionLastVideoNetwork() }
    
    // 进度条
    @IBOutlet weak var progressViewVideoNetwork: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    private func actionPlayVideoCapture() {
        
        // 暂时去掉录制视频的播放
        return
        
        if avPlayer != nil {
            avPlayer.pause()
            viewVideoNetwork.bringSubview(toFront: btnPlayVideoNetwork)
        }
        
        videoURLString = videoPath
        
        // 录制的视频
        let videoURL = URL(fileURLWithPath: videoURLString)
        
        // 视频的一些信息，一个item对应一个视频资源
        let avPlayerItem = AVPlayerItem(url: videoURL)
        avPlayer = AVPlayer(playerItem: avPlayerItem)
        
        // 播放的layer层
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = viewVideoCapture.bounds
        avPlayerLayer.backgroundColor = UIColor.black.cgColor
        avPlayerLayer.videoGravity = AVLayerVideoGravityResize
        viewVideoCapture.layer.addSublayer(avPlayerLayer)
        
//        avPlayerVC = AVPlayerViewController()
//        avPlayerVC.player = avPlayer
//
//        present(avPlayerVC, animated: true) {
//            self.avPlayer.play()
//        }
    }
    
    private func actionPlayVideoNetwork() {
        isVideoPlaying = !isVideoPlaying
        
        if avPlayer == nil {
            // 网络请求的视频
            videoURLString = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
            
            let videoURL = URL(string: videoURLString)
            
            // 视频的一些信息
            let avPlayerItem = AVPlayerItem(url: videoURL!)
            avPlayer = AVPlayer(playerItem: avPlayerItem)
            
            // 监听播放进度
            avPlayer.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (time) in
                
                let total = Float(CMTimeGetSeconds(avPlayerItem.duration))
                let current = Float(CMTimeGetSeconds(time))
                if current > 0 {
                    self.progressViewVideoNetwork.progress = current / total
                }
                
                if self.progressViewVideoNetwork.progress == 1 {
                    print("Done")
                    self.btnPlayVideoNetwork.setImage(UIImage(named: "btnPlay"), for: .normal)
                    self.progressViewVideoNetwork.progress = 0
                }
                
            })
            
            // 播放的layer层
            let avPlayerLayer = AVPlayerLayer(player: avPlayer)
            avPlayerLayer.frame = viewVideoNetwork.bounds
            avPlayerLayer.backgroundColor = UIColor.black.cgColor
            avPlayerLayer.videoGravity = AVLayerVideoGravityResize
            viewVideoNetwork.layer.addSublayer(avPlayerLayer)
            
            avPlayer.play()
            
            btnPlayVideoNetwork.setImage(UIImage(named: "btnPause"), for: .normal)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(VideoPlayViewController.actionTapGesture(_:)))
            viewVideoNetworkOperation.addGestureRecognizer(tapGesture)
        } else {
            if isVideoPlaying {
                // 可通过avPlayer.rate == 1.0来判断
                avPlayer.play()
                
                btnPlayVideoNetwork.setImage(UIImage(named: "btnPause"), for: .normal)
            } else {
                avPlayer.pause()
                
                btnPlayVideoNetwork.setImage(UIImage(named: "btnPlay"), for: .normal)
            }
        }
    }
    
    func actionNextVideoNetwork() {
        avPlayer.pause()
        
        videoURLString = "https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8"
        
        let videoURL = URL(string: videoURLString)
        
        // 视频的一些信息
        let avPlayerItem = AVPlayerItem(url: videoURL!)
        
        // 使用replace item即可切换视频
        avPlayer.replaceCurrentItem(with: avPlayerItem)
        
        avPlayer.play()
    }
    
    func actionLastVideoNetwork() {
        avPlayer.pause()
        
        videoURLString = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
        
        let videoURL = URL(string: videoURLString)
        
        // 视频的一些信息
        let avPlayerItem = AVPlayerItem(url: videoURL!)
        
        avPlayer.replaceCurrentItem(with: avPlayerItem)
        
        avPlayer.play()
    }
    
    func actionTapGesture(_ sender: UITapGestureRecognizer) {
        if isVideoPlaying {
            isOperationShowing = !isOperationShowing
            
            btnPlayVideoNetwork.isHidden = isOperationShowing
            progressViewVideoNetwork.isHidden = isOperationShowing
        }
    }

}
