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
    
    // 缓冲进度条
    @IBOutlet weak var progressViewVideoNetworkLoading: UIProgressView!
    
    // 播放进度条
    @IBOutlet weak var sliderPlayProgress: UISlider!
    @IBOutlet weak var lbPlayProgress: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(VideoPlayViewController.actionPlayVideoNetworkDone(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
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
    
    func timeString(_ time: Int) -> String {
        let hour = time / 3600
        let min = time / 60
        let sec = time % 60
        
        var minStr = ""
        var secStr = ""
        minStr = min > 9 ? "\(min)" : "0\(min)"
        secStr = sec > 9 ? "\(sec)" : "0\(sec)"
        
        if hour == 0 {
            return "\(minStr):\(secStr)"
        } else {
            var hourStr = ""
            hourStr = hour > 9 ? "\(hour)" : "0\(hour)"
            return "\(hourStr):\(minStr):\(secStr)"
        }
    }
    
    private func actionPlayVideoNetwork() {
        isVideoPlaying = !isVideoPlaying
        
        if avPlayer == nil {
            // 网络请求的视频
            videoURLString = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
            
            let videoURL = URL(string: videoURLString)
            
            // 视频的一些信息
            let avPlayerItem = AVPlayerItem(url: videoURL!)
            // 通过status来查看是否可以播放，即检测到AVPlayerStatusReadyToPlay之后调用play即可
            // loadedTimeRanges代表已经缓冲的进度，通过KVO来监控缓冲进度即可
            avPlayerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
            
            avPlayer = AVPlayer(playerItem: avPlayerItem)
            
            // 监听播放进度
            avPlayer.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (time) in
                
                let total = lroundf(Float(CMTimeGetSeconds(avPlayerItem.duration)))
                let current = lroundf(Float(CMTimeGetSeconds(time)))
                if current > 0 {
                    self.sliderPlayProgress.value = Float(current) / Float(total)
                    
                    self.lbPlayProgress.text = self.timeString(total - current)
                }
                
                // 也可以使用AVPlayerItemDidPlayToEndTime通知
                if self.sliderPlayProgress.value == 1 {
                    self.btnPlayVideoNetwork.setImage(UIImage(named: "btnPlay"), for: .normal)
                    self.sliderPlayProgress.value = 0
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
            btnLastVideoNetwork.isHidden = isOperationShowing
            btnNextVideoNetwork.isHidden = isOperationShowing
            sliderPlayProgress.isHidden = isOperationShowing
            progressViewVideoNetworkLoading.isHidden = isOperationShowing
            lbPlayProgress.isHidden = isOperationShowing
        }
    }
    
    func actionPlayVideoNetworkDone(_ sender: Notification) {
        print("Done")
    }

}

// MARK: - 通过KVO的方式来监控缓冲进度
extension VideoPlayViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let loadedTimeRanges = avPlayer.currentItem?.loadedTimeRanges
        guard let timeRange = loadedTimeRanges?.first else { return }// 缓冲区域
        let cmTimeRange = timeRange as CMTimeRange
        let start = cmTimeRange.start
        let duration = cmTimeRange.duration
        let loading = lroundf(Float(start.value) + Float(duration.value))
        let total = lroundf(Float(CMTimeGetSeconds((avPlayer.currentItem?.duration)!)))
        
        progressViewVideoNetworkLoading.progress = Float(loading) / Float(total)
        
    }
}



