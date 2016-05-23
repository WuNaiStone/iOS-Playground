//
//  ViewController.swift
//  DBFM
//
//  Created by Chris Hu on 14-7-22.
//  Copyright (c) 2014年 edu.self. All rights reserved.
//

import UIKit
import MediaPlayer
import QuartzCore
import Social

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    HttpProtocol, ChannelProtocol {
    
    @IBOutlet var iv: UIImageView!
    //UITableView 用来存储 songs 列表
    @IBOutlet var tv: UITableView!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet var playTime: UILabel!
    @IBOutlet var btnPlay: UIImageView!
    
    @IBOutlet weak var btnLast: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var songs: NSArray = NSArray()
    var channels: NSArray = NSArray()
    
    //用于存储 image 和对应的 url
    var imageCache = Dictionary<String, UIImage>()
    var timer: NSTimer?
    var curSongIndex: Int = 0
    var tarSongIndex: Int = 0
    
    var httpCtl: HttpController = HttpController()
    var audioPlayer: MPMoviePlayerController = MPMoviePlayerController()
    
    @IBAction func onPause(sender: UITapGestureRecognizer) {
        //点击图片，可以暂停播放
        //使用 UITapGestureRecognizer, 则点击其他不会生成歧义动作的区域,就会调用该函数.
        if sender.view == btnPlay {
            btnPlay.hidden = true
            audioPlayer.play()
            btnPlay.removeGestureRecognizer(tap)
            iv.addGestureRecognizer(tap)
        } else if sender.view == iv {
            btnPlay.hidden = false
            audioPlayer.pause()
            btnPlay.addGestureRecognizer(tap)
            iv.removeGestureRecognizer(tap)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        httpCtl.delegate = self
        httpCtl.onRequest("http://www.douban.com/j/app/radio/channels")
        httpCtl.onRequest("http://douban.fm/j/mine/playlist?channel=0")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        var channelCtl: ChannelController = segue.destinationViewController as! ChannelController
        channelCtl.delegate = self
        //将channels传递给ChannelController中去。
        channelCtl.channels = channels
    }
    
    func onChangeChannel(channel: String){
        //在 ChannelCtl 中调用,且会用到 httpCtl 的 onRequest, 所以采用 delegate.
        let url: String = "http://douban.fm/j/mine/playlist?\(channel)"
        httpCtl.onRequest(url);
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
        //即单元格cell长什么样的？
        //reloadData的时候会调用该方法，填充每个cell的内容。
        //图片的加载（imageCache的填充），需要手动刷新一下songs，才会出现。
            
        //通过Identifier来识别cell，可以设置cell identifier 的选择条件
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "song")
            
        //按照indexPath来取出每一个cell。
        let rowData: NSDictionary = songs[indexPath.row] as! NSDictionary
        cell.textLabel?.text = rowData["title"] as? String
        cell.detailTextLabel?.text = rowData["artist"] as? String
//        cell.detailTextLabel?.text = (rowData["artist"] as String)
        //未刷新则使用默认图片.
        cell.imageView?.image = UIImage(named:"detail.jpg")

        //该图片若已存储,则直接使用;否则,存储到 imageCache 中.
        let url = rowData["picture"] as! String
        let image = imageCache[url] as UIImage!
        if image == nil {
            let imgURL: NSURL = NSURL(string: url)!
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            //闭包有 in 关键字,类似匿名函数.
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                var img = UIImage(data: data)
                cell.imageView?.image = img
                //此处闭包中的 self 必须有
                self.imageCache[url] = img
                })
        } else {
            cell.imageView?.image = image
        }
        return cell
    }	
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // tableView(tv, callback) 貌似不能多次嵌套使用.
//        var curIndexPath: NSIndexPath?
////        curIndexPath = tv.indexPathForSelectedRow()?
//        println("curSongIndex : \(curSongIndex)")
//        curIndexPath = NSIndexPath(forRow: curSongIndex, inSection: 0)
//        println("curIndexPath : \(curIndexPath)")
//        if curIndexPath != nil {
//            var curCell: UITableViewCell = tv.cellForRowAtIndexPath(curIndexPath!)!
//            println("1 \(curCell.selected)")
////            tv.deselectRowAtIndexPath(curIndexPath!, animated: true)
//            println("2 \(curCell.selected)")
//            curCell.setSelected(false, animated: false)
//            println("3 \(curCell.selected)")
//        }
//        var cell: UITableViewCell = tv.cellForRowAtIndexPath(indexPath)!
//        println("indexPath : \(indexPath)")
////        cell.setSelected(true, animated: false)

        didChooseSong(indexPath.row)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath){
        //cell 加载显示的方式变成动画
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func didReceiveResults(results: NSDictionary) {
        //接收的参数为NSDictionary：delegate?.didReceiveResults(jsonResult)
        if results["song"] != nil {
            songs = results["song"] as! NSArray
            //一旦httpCtl 的结果是 song, 则立即重新加载 tv 的数据.并播放第一首.
            //这样即响应了第一次打开 APP 加载 songs, 也响应了选择 channel, 重新加载 songs
            tv.reloadData()
            
            curSongIndex = 0
            tarSongIndex = 0
            let indexPath = NSIndexPath(forRow: tarSongIndex, inSection: 0)
            tableView(tv, didSelectRowAtIndexPath: indexPath)
 
            iv.addGestureRecognizer(tap)
        } else if results["channels"] != nil {
            //结果是 channels, 则填充 channels而已,不做其他操作.
            channels = results["channels"] as! NSArray
        }
    }
    
    func didChooseSong(index: NSInteger){
        //接收的参数为indexPath.row，一个NSInteger类型。
        let rowData: NSDictionary = songs[index] as! NSDictionary
        let audioUrl: String = rowData["url"] as! String
        didSetAudio(audioUrl)
        let imgUrl: String = rowData["picture"] as! String
        didSetImage(imgUrl)
        
        //设置为0，否则每次重新选取歌曲的时候，都会出现进度条回退的情况。
        progressView.progress = 0.0
        progressView.setProgress(0, animated: true)
        
        curSongIndex = index
    }
    
    func didSetAudio(url: String){
        //重新播放歌曲.先让timer失效，即每次播放的时候都从0开始计时
        timer?.invalidate()
        playTime.text = "00:00"
        audioPlayer.stop()
        audioPlayer.contentURL = NSURL(string: url)
        
        //代码执行顺序在网络情况不好的时候,能看出来区别.即先加载手势,还是先播放?
        btnPlay.hidden = true
        btnPlay.removeGestureRecognizer(tap)
        iv.addGestureRecognizer(tap)
        
        audioPlayer.play()
        //设置timer，定时调用onUpdate函数。
        timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self,
            selector: "onUpdate", userInfo: nil, repeats: true)
    }
    
    func onUpdate(){
        let curTime = audioPlayer.currentPlaybackTime
        if curTime > 0.0 {
            // dur 中包含的就是总共所需播放的时间，将其跟progressView关联起来即可。
            let dur = audioPlayer.duration
            let pro: CFloat = CFloat(curTime / dur)
            progressView.setProgress(pro, animated: true)
            
            var timeText: String = ""
            let min: Int = Int(Int(curTime) / 60)
            let sec: Int = Int(curTime) % 60
            if min < 10 {
                timeText = "0\(min)"
            } else {
                timeText = "\(min)"
            }
            timeText += ":"
            if sec < 10 {
                timeText += "0\(sec)"
            } else {
                timeText += "\(sec)"
            }
            playTime.text = timeText
        }
        if progressView.progress == 1.0 {
            didNextSong()
        }
    }
    
    func didSetImage(url: String){
        let image = imageCache[url] as UIImage!
        if image == nil {
            let request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                var img = UIImage(data: data)
                //此处闭包中的 self 必须有
                self.iv.image = img
                self.imageCache[url] = img
                })
        } else {
            iv.image = image
        }
    }
    
    @IBAction func nextSong(sender: AnyObject) {
        didNextSong()
    }
    
    func didNextSong() {
        if curSongIndex == (songs.count - 1) {
            tarSongIndex = 0
        } else {
            tarSongIndex = curSongIndex + 1
        }
        var indexPath: NSIndexPath = NSIndexPath(forRow: tarSongIndex, inSection: 0)
        println(indexPath)
        tableView(tv, didSelectRowAtIndexPath: indexPath)
    }

    @IBAction func lastSong(sender: AnyObject) {
        didLastSong()
    }
    
    func didLastSong() {
        if curSongIndex == 0 {
            tarSongIndex = songs.count - 1
        } else if curSongIndex == 1 {
            tarSongIndex = 0
        } else {
            tarSongIndex = curSongIndex - 1
        }
        var indexPath: NSIndexPath = NSIndexPath(forRow: tarSongIndex, inSection: 0)
//        println(indexPath)
        tableView(tv, didSelectRowAtIndexPath: indexPath)
    }

    
    @IBAction func shareTapped(sender: UIBarButtonItem) {
        var controller: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        controller.setInitialText("随便听听, 不要让自己迷失在选择中!")
        controller.addImage(iv.image)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}

