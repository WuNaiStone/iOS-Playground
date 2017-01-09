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
    var avPlayer: AVPlayerViewController!
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBAction func actionBtnBack(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBAction func actionBtnPlay(_ sender: UIButton) { actionPlay() }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    
    func actionPlay() {
        let avPlayerVC = AVPlayerViewController()
        
        let avPlayer = AVPlayer(url: URL(fileURLWithPath: videoPath))
        avPlayerVC.player = avPlayer
        
        present(avPlayerVC, animated: true) { 
            avPlayer.play()
        }
    }

}
