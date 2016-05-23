DBFM
====

豆瓣FM的iphone客户端


DBFM:


1. 豆瓣API

频道列表: http://www.douban.com/j/app/radio/channels

歌曲列表: http://douban.fm/j/mine/playlist?channel=0


2. AppDelegate.swift

程序入口 @UIApplicationMain


3. ViewController.swift

APP的主视图，FM的基本播放及控制功能


4. HttpController.swift

封装了一个异步的HTTP请求：NSURLConnection.sendAsynchronousRequest


5. ChannelController.swift

用于进行FM频道的切换。

6. 后续优化（等待）。
代码深度理解及优化
播放一首结束后,自动调至下一首播放-切换之后 cell 未选中?
使用 navigation controller 实现界面跳转-完成
UI 美化及图标制作
分享功能
提交

