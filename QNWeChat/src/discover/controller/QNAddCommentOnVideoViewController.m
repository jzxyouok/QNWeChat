//
//  QNAddCommentOnVideoViewController.m
//  QNWeChat
//
//  Created by smartrookie on 16/8/17.
//  Copyright © 2016年 smartrookie. All rights reserved.
//

#import "QNAddCommentOnVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "UIBarButtonItem+QNExtention.h"

@interface QNAddCommentOnVideoViewController ()

@property (strong, nonatomic) AVPlayerViewController *playerControl;
@property (strong, nonatomic) AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *playerContainerView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
@implementation QNAddCommentOnVideoViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initTitle];
    [self initLeftNavigationItem];
    [self initRightNavigationItem];
    [self initPlayerView];
    [self setupInputView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(comeToFroeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)initTitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"朋友圈";
    self.navigationItem.titleView = label;
}

- (void)initLeftNavigationItem
{
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithTitle:@"取消" textColor:[UIColor colorWithR:130 G:231 B:70] target:self action:@selector(leftItemClicked:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initRightNavigationItem
{
    UIBarButtonItem *sendMacroItem = [UIBarButtonItem itemWithTitle:@"发送" textColor:[UIColor colorWithR:130 G:231 B:70] target:self action:@selector(sendMacroVideoItemClicked:)];
    self.navigationItem.rightBarButtonItem = sendMacroItem;
}

- (void)initPlayerView
{
    self.playerControl = [[AVPlayerViewController alloc] init];
    self.player = [AVPlayer playerWithURL:self.recordURL];
    self.player.actionAtItemEnd = AVPlayerActionAtItemEndPause;
    self.playerControl.player = self.player;
    self.playerControl.player.volume = 0.0f;
    self.playerControl.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.playerControl.showsPlaybackControls = false;
    [self.playerControl.player play];
    [self.playerContainerView addSubview:self.playerControl.view];
    [self.playerControl.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.playerContainerView);
    }];
}

- (void)setupInputView
{
    
    [self.inputView becomeFirstResponder];
}

- (void)sendMacroVideoItemClicked:(UIButton *)btn
{
    
}
- (void)leftItemClicked:(id)sm
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)runLoopTheMovie:(NSNotification *)notification
{
    [self.player seekToTime:kCMTimeZero];
    
    [self.playerControl.player play];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.player play];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)comeToFroeground:(NSNotification *)notification
{
    [self.player play];
}

@end
