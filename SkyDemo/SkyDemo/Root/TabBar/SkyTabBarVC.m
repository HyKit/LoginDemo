//
//  SkyTabBarVC.m
//  SWK
//
//  Created by 李亨达 on 15-4-2.
//  Copyright (c) 2015年 Kxtx. All rights reserved.
//

#import "SkyTabBarVC.h"
#import "SkyTabBarButton.h"




#define TABBARHEIGHT    49


@interface SkyTabBarVC ()





@end

@implementation SkyTabBarVC
{
    SkyTabBarButton *btnOne;
    SkyTabBarButton *btnTwo;
    UIButton *btnCenter;
    SkyTabBarButton *btnFour;
    SkyTabBarButton *btnFive;
    UIView *newView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:@"Login2" object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh) name:@"RoleChange" object:nil];
    
    //
    CGRect f=self.tabBar.frame;
    f.origin.y=ScreenHeight-TABBARHEIGHT;
    f.size.height=TABBARHEIGHT;
    [self.tabBar removeFromSuperview];
    
    UIView *view =[[UIView alloc]init];
    view.frame=f;
    [view setBackgroundColor:RGBACOLOR(245,245,245,1)];
    [self.view addSubview:view];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth,1)];
    [line setBackgroundColor:RGBACOLOR(222, 222, 222, 1)];
    [view addSubview:line];
    

    
    //中间按钮
    btnCenter=[[UIButton alloc]init];
    [btnCenter setFrame:CGRectMake(0,0,ScreenWidth * 60.5 / 320.0,ScreenWidth*50.5/320)];
    [btnCenter setCenter:CGPointMake(ScreenWidth/2,TABBARHEIGHT-btnCenter.frame.size.height/2+4)];
    [btnCenter setImage:[UIImage imageNamed:@"shouye_no"] forState:UIControlStateNormal];
    [btnCenter setTag:2];
    [view addSubview:btnCenter];
    [btnCenter addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat buttonWidth = (ScreenWidth - btnCenter.frame.size.width) / 4;
    


    
    //右边按钮
    UIColor *normalColor = RGBACOLOR(128, 128, 130, 1);
    UIColor *selectedColor = RGBACOLOR(236, 108, 0, 1);
    UIImage *normalImage = [UIImage imageNamed:@"CenterBtn"];
    UIImage *selectedImage = [UIImage imageNamed:@"CenterBtn_"];
    
    btnOne = [self createButtonWithFrame:CGRectMake(0,0,buttonWidth,TABBARHEIGHT) title:@"侧边动画" fontSize:12 normalColor:normalColor selectedColor:selectedColor normalImage:normalImage selectedImage:selectedImage tag:0 target:@selector(clickBtn:)];
    btnTwo = [self createButtonWithFrame:CGRectMake(buttonWidth,0,buttonWidth,TABBARHEIGHT) title:@"首页" fontSize:12 normalColor:normalColor selectedColor:selectedColor normalImage:normalImage selectedImage:selectedImage tag:1 target:@selector(clickBtn:)];
    btnFour = [self createButtonWithFrame:CGRectMake(ScreenWidth-buttonWidth * 2,0,buttonWidth,TABBARHEIGHT) title:@"第四个" fontSize:12 normalColor:normalColor selectedColor:selectedColor normalImage:normalImage selectedImage:selectedImage tag:3 target:@selector(clickBtn:)];
    btnFive = [self createButtonWithFrame:CGRectMake(ScreenWidth-buttonWidth,0,buttonWidth,TABBARHEIGHT) title:@"个人中心" fontSize:12 normalColor:normalColor selectedColor:selectedColor normalImage:normalImage selectedImage:selectedImage tag:4 target:@selector(clickBtn:)];
    [btnFive addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btnOne];
    [view addSubview:btnTwo];
    [view addSubview:btnFour];
    [view addSubview:btnFive];
    
    btnOne.selected=YES;
    self.selectedBtn=btnOne;
//    popVC = [[PopViewController alloc] init];
//    popNav = [[UINavigationController alloc] initWithRootViewController:popVC];
    

}


- (void)clickBtn:(id)sender {
    UIButton *button = (UIButton *)sender;
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    
    
    if (button.tag == 2) {
        //点击的是中间按钮
//        [self showMenu];
        
    }
    else {
        //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
        self.selectedIndex = button.tag;
    }
}




-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark --- 私有方法

- (SkyTabBarButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag target:(SEL)target {
    SkyTabBarButton *button = [[SkyTabBarButton alloc] init];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button setTag:tag];
    [button addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];
    return button;
}




 
@end
