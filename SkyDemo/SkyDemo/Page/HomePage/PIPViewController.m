//
//  PIPViewController.m
//  SkyDemo
//
//  Created by 何亚慧 on 2017/3/27.
//  Copyright © 2017年 Sky. All rights reserved.
//

#import "PIPViewController.h"
#import "UIImage+Extra.h"

@interface PIPViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)originalBtnClicked:(id)sender;
- (IBAction)whiteImgClicked:(UIButton *)sender;


@end

@implementation PIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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

- (IBAction)originalBtnClicked:(id)sender {
    [_imageView setImage:[UIImage imageNamed:@"1"]];
}
- (IBAction)whiteImgClicked:(UIButton *)sender {
    [_imageView setImage:[UIImage pictureTheWhitening:[UIImage imageNamed:@"1"]]];
}
@end
