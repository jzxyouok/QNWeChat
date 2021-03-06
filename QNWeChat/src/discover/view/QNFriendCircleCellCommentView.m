//
//  QNFriendCircleCellCommentView.m
//  QNWeChat
//
//  Created by smartrookie on 16/8/23.
//  Copyright © 2016年 smartrookie. All rights reserved.
//

#import "QNFriendCircleCellCommentView.h"
#import "YYLabel.h"
#import "QNFriendCircleModel.h"

@interface QNFriendCircleCellCommentView ()

@property (strong, nonatomic) YYLabel *loverLabel;
@property (strong, nonatomic) QNFriendCircleModel *model;

@end

@implementation QNFriendCircleCellCommentView

-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)updateContent:(QNFriendCircleModel *)model
{
    self.model = model;
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }

    [self updateLoverList:model.loverList];
    [self updateCommentView:model];
    
}

-(void)updateLoverList:(NSArray *)lovers
{
    self.loverLabel = [[YYLabel alloc] init];
    [self addSubview:self.loverLabel];
    self.backgroundColor = [UIColor colorWithR:243 G:243 B:245];
    self.loverLabel.textColor = Globle_WeChat_UserNameLabel_Color;
    self.loverLabel.font = [UIFont boldSystemFontOfSize:13];
    WS(weakSelf);
    self.loverLabel.textTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        weakSelf.loverLabel.backgroundColor = [UIColor lightGrayColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.loverLabel.backgroundColor = [UIColor clearColor];
        });
    };
    
    if (self.model.ILoveThis) {
        self.loverLabel.text = @"测试姓名呵呵哒";
        [self.loverLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset = 10;
            make.top.equalTo(self).offset = 5;
        }];
    } else {
        [self.loverLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset = 10;
            make.top.equalTo(self).offset = 0;
        }];
        self.loverLabel.text = @"";
    }
}

- (void)updateCommentView:(QNFriendCircleModel *)model;
{
    if (model.commentArray.count > 0) {
        
        __block UILabel *lastLabel = nil;
        
        [model.commentArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            label.font = [UIFont boldSystemFontOfSize:13];
            label.numberOfLines = 0;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",obj[@"commentPerson"],obj[@"commentContent"]]];
            NSString *name = obj[@"commentPerson"];
            NSString *content = [NSString stringWithFormat:@"%@:%@",obj[@"commentPerson"],obj[@"commentContent"]];
            
            [string setAttributes:@{NSForegroundColorAttributeName:Globle_WeChat_UserNameLabel_Color} range:NSMakeRange(0, name.length)];
            [string setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(name.length, content.length - name.length)];
            
            label.attributedText = string;
            
            if (idx == 0) {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.loverLabel.mas_bottom).offset = 2;
                    make.left.equalTo(self).offset = 10;
                    make.right.equalTo(self.mas_right);
                }];
            } else {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastLabel.mas_bottom).offset = 2;
                    make.left.equalTo(self).offset = 10;
                    make.right.equalTo(self.mas_right);
                }];
            }
            lastLabel = label;
        }];
        
        [lastLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    } else {
        if (self.model.ILoveThis) {
            [self.loverLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom).offset = -5;
            }];
        }else {
            [self.loverLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            self.loverLabel.text = @"";
        }

    }
}

@end
