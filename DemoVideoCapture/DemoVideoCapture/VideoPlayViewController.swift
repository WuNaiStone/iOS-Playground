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
    @IBOutlet weak var btnPlayVideoNetwork: UIButton!
    @IBAction func actionBtnPlayVideoNetwork(_ sender: UIButton) { actionPlayVideoNetwork() }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.avPlayer.play()
    }
    
    private func actionPlayVideoNetwork() {
        if avPlayer != nil {
            avPlayer.pause()
            viewVideoCapture.bringSubview(toFront: btnPlayVideoCapture)
        }
        
        // 网络请求的视频
        videoURLString = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
        
        let videoURL = URL(string: videoURLString)
        
        // 视频的一些信息
        let avPlayerItem = AVPlayerItem(url: videoURL!)
        avPlayer = AVPlayer(playerItem: avPlayerItem)
        
        // 播放的layer层
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = viewVideoNetwork.bounds
        avPlayerLayer.backgroundColor = UIColor.black.cgColor
        avPlayerLayer.videoGravity = AVLayerVideoGravityResize
        viewVideoNetwork.layer.addSublayer(avPlayerLayer)
        
//        avPlayerVC = AVPlayerViewController()
//        avPlayerVC.player = avPlayer
        
        //        present(avPlayerVC, animated: true) {
        self.avPlayer.play()
        //        }
    }

}
