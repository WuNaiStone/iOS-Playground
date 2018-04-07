//
//  ViewController.m
//  DemoAudioPlayer
//
//  Created by zj－db0465 on 03/04/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>

@interface ViewController () <
    UITableViewDataSource,
    UITableViewDelegate
>

// 音频资源
@property (nonatomic, copy) NSArray <NSURL *> *audios;
// 当前正在播放的音频序号
@property (nonatomic, assign) NSInteger currentIndexOfPlayingAudio;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *btnAudioPlay;

// audioPlayer
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) BOOL isAudioPlaying;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAudioSession];
    [self setupAudios];
    self.currentIndexOfPlayingAudio = -1;
    
    [self.view addSubview:self.btnAudioPlay];
    [self.view addSubview:self.tableView];
}

- (void)setupAudioSession {
    // 设置后台播放, 同时在plist中添加:
    /**
     <key>UIBackgroundModes</key>
     <array>
     <string>audio</string>
     </array>
     */
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)setupAudios {
    self.audios = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"m4a" subdirectory:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60 - 100);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIButton *)btnAudioPlay {
    if (!_btnAudioPlay) {
        _btnAudioPlay = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80) / 2, self.view.frame.size.height - 100, 80, 80)];
        [_btnAudioPlay setTitle:@"Play" forState:UIControlStateNormal];
        [_btnAudioPlay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnAudioPlay addTarget:self action:@selector(actionBtnAudioPlay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAudioPlay;
}

- (void)actionBtnAudioPlay:(UIButton *)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"设计" ofType:@"m4a"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self p_playAudio:url];
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.audios.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    NSString *file = [self.audios[indexPath.row].path lastPathComponent];
    cell.textLabel.text = [file stringByReplacingOccurrencesOfString:@".m4a" withString:@""];
    
    return cell;
}

// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndexOfPlayingAudio != -1 &&
        self.currentIndexOfPlayingAudio != indexPath.row) {
        [self.audioPlayer stop];
    }
    
    NSURL *url = self.audios[indexPath.row];
    [self p_playAudio:url];
}

- (void)p_playAudio:(NSURL *)url {
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
    self.isAudioPlaying = YES;
}

@end
