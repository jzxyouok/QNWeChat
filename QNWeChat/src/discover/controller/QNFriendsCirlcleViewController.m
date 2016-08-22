//
//  QNFriendsCirlcleViewController.m
//  QNWeChat
//
//  Created by smartrookie on 16/8/13.
//  Copyright © 2016年 smartrookie. All rights reserved.
//

#import "QNFriendsCirlcleViewController.h"
#import "UIBarButtonItem+QNExtention.h"
#import "ACHeadImageChooseOptionView.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface QNFriendsCirlcleViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *sendFriendsCirlceMediaTypeDataSource;

@end

@implementation QNFriendsCirlcleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
}

- (void)initData
{
    self.sendFriendsCirlceMediaTypeDataSource = @[@"小视频",@"拍照",@"从手机相册选择"];
}

- (void)setupView
{
    [self initNavigationRightItem];
}

- (void)initNavigationRightItem
{
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"barbuttonicon_Camera" highImage:nil target:self action:@selector(rightBarButtonItemClicked:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightBarButtonItemClicked:(UIButton *)item
{
    ACHeadImageChooseOptionView *optionView = [[ACHeadImageChooseOptionView alloc] initWithFrame:self.view.frame];
    optionView.dataSource = self.sendFriendsCirlceMediaTypeDataSource;
    [optionView whenTapped:^(ACChooseHeadImageType type) {
        
        NSString *chooseType = self.sendFriendsCirlceMediaTypeDataSource[type];
        
        if ([chooseType isEqualToString:@"小视频"]) {
        
            [self performSegueWithIdentifier:@"friendCircleModelToRecordVideo" sender:nil];
            
        } else if ([chooseType isEqualToString:@"拍照"]) {
            
            BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            
            if (isCameraSupport) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                [[imagePicker navigationBar] setTintColor:[UIColor whiteColor]];
                [[imagePicker navigationBar] setBarTintColor:[UIColor blackColor]];
                [[imagePicker navigationBar] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            
        } else if ([chooseType isEqualToString:@"从手机相册选择"]) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            [[imagePicker navigationBar] setTintColor:[UIColor whiteColor]];
            [[imagePicker navigationBar] setBarTintColor:[UIColor blackColor]];
            [[imagePicker navigationBar] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
        
    }];
    [optionView show];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        if ([picker allowsEditing]){
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
