//
//  QNFriendCircleStatusView.m
//  QNWeChat
//
//  Created by smartrookie on 16/8/23.
//  Copyright © 2016年 smartrookie. All rights reserved.
//

#import "QNFriendCircleStatusView.h"

@interface QNFriendCircleStatusView ()

@property (strong, nonatomic) NSDictionary *infoDic;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) UIButton *showCommentLoveButton;
@property (strong, nonatomic) UIView *assessView;
@property (nonatomic, assign) BOOL showAssessView;
@property (nonatomic, strong) UIButton *zanButton;

@end

@implementation QNFriendCircleStatusView

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    self.clipsToBounds = NO;
    // time label
    self.timeLabel = [[UILabel alloc] init];
    [self addSubview:self.timeLabel];
    self.timeLabel.text = @"22小时前";
    self.timeLabel.font = [UIFont boldSystemFontOfSize:12];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //delete button
    self.deleteButton = [[UIButton alloc] init];
    [self addSubview:self.deleteButton];
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    self.deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [self.deleteButton setTitleColor:[UIColor colorWithR:88 G:108 B:148] forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset = 15;
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //comment love button
    self.showCommentLoveButton = [[UIButton alloc] init];
    [self addSubview:self.showCommentLoveButton];
    [self.showCommentLoveButton setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateNormal];
    [self.showCommentLoveButton addTarget:self action:@selector(showCommentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.showCommentLoveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //assessView
    self.assessView = [[UIView alloc] init];
    [self addSubview:self.assessView];
    self.assessView.backgroundColor = [UIColor colorWithR:76 G:81 B:84];
    self.assessView.layer.cornerRadius = 3;
    [self.assessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.showCommentLoveButton.mas_left).offset = -3;
        make.centerY.equalTo(self.showCommentLoveButton.mas_centerY);
        make.width.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    // zan button
    self.zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.assessView addSubview:self.zanButton];
    [self.zanButton setTitle:@"赞" forState:UIControlStateNormal];
    [self.zanButton addTarget:self action:@selector(loveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.zanButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.zanButton setTitleColor:[UIColor colorWithR:242 G:242 B:242] forState:UIControlStateNormal];
    [self.zanButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.assessView);
        make.left.equalTo(self.assessView);
        make.bottom.equalTo(self.assessView.mas_bottom);
        make.width.equalTo(@0);
    }];
    
    //comment button
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.assessView addSubview:commentButton];
    [commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor colorWithR:242 G:242 B:242] forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [commentButton addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    commentButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zanButton.mas_right);
        make.top.equalTo(self.assessView);
        make.bottom.equalTo(self.assessView.mas_bottom);
        make.right.equalTo(self.assessView.mas_right);
    }];
}

- (void)deleteButtonClicked:(UIButton *)btn
{
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

- (void)loveButtonClicked:(UIButton *)btn
{
    if (self.loveBlock) {
        self.loveBlock();
    }
}

- (void)commentButtonClicked:(UIButton *)btn
{
    if (self.commentBlock) {
        self.commentBlock();
    }
}

- (void)showCommentButtonClicked:(UIButton *)btn
{
    if (!self.showAssessView) {
        
        //show
        [self.assessView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@150);
        }];
        [self.zanButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@75);
        }];
        
        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self layoutIfNeeded];

        } completion:nil];
        
        self.showAssessView = YES;
        
    } else {
        
        //hide
        [self.zanButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
        [self.assessView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];

        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
        self.showAssessView = NO;
    }
}

-(void)hideCommentView
{
    self.showAssessView = YES;
    [self showCommentButtonClicked:nil];
}

@end


