//
//  UserCenterVC.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/19.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "UserCenterVC.h"
#import "PointsViewController.h"




#define TableViewTitle @"title"
#define TableViewVC    @"vc"
#define TableViewImage @"image"
#define TableViewCellHeight  @"cellHeight"



@interface UserCenterVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataSource;
    UITableView *_tableView;
    CGFloat _imageHeight;  //背景图片的高度
    
    
}

@property(nonatomic, strong) UITableView  *tableView;

//下拉变大视图
@property(nonatomic, strong)UIImageView *headerBackView;
@property(nonatomic, strong)UIImageView *photoImageView;
@property(nonatomic, strong)UIView *tableViewHeaderView;

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *introduceLabel;

@end

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.title = @"个人中心";
    
    _imageHeight = 200;//背景图片的高度
    [self initNavigationBar];
    
    [self configTableViewDataSource];
    [self configTableView];
    [self createTableViewHeaderView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
#pragma mark --- subviews  config
- (void)configTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


- (void)configTableViewDataSource {
    _dataSource = @[
                             
                             @{
                                 TableViewTitle : @"积分",
                                 TableViewImage : @"",
                                 TableViewVC    : @"PointsViewController",
                                 TableViewCellHeight : @"70.0f",
                                 },
                             @{
                                 TableViewTitle : @"图片",
                                 TableViewImage : @"",
                                 TableViewVC    : @"PhotoAnimationVC",
                                 },
                             @{
                                 TableViewTitle : @"未知",
                                 TableViewImage : @"",
                                 TableViewVC    : @"",
                                 },
                             ];
}

- (void)initNavigationBar {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 15, 41*15/25);
    [button setTitle:@"扩展" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toExtern:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
}


#pragma mark --- 创建下拉变大的视图
-(void)createTableViewHeaderView {
    
    _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _imageHeight)];
    
    //背景图
    _headerBackView = [[UIImageView alloc] initWithFrame:_tableViewHeaderView.bounds];
    _headerBackView.image = [UIImage imageNamed:@"bg"];
    [_tableViewHeaderView addSubview:_headerBackView];
    
    _photoImageView = [UIImageView new];
    [_tableViewHeaderView addSubview:_photoImageView];
    
    WS(ws);
    
    
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.tableViewHeaderView.mas_centerX);
        make.bottom.equalTo(ws.tableViewHeaderView.mas_bottom).offset(-70);
        make.width.and.height.mas_equalTo(70);
    }];
    
    _photoImageView.layer.cornerRadius = 35.0f;
    _photoImageView.layer.masksToBounds = YES;

    _photoImageView.image = [UIImage imageNamed:@"avatar"];
    
    _userNameLabel = [UILabel new];
    _introduceLabel = [UILabel new];
    [_tableViewHeaderView addSubview:_userNameLabel];
    [_tableViewHeaderView addSubview:_introduceLabel];
    
    [self setLableWith:_userNameLabel fontSize:16.0f title:@"货运圈"];
    [self setLableWith:_introduceLabel fontSize:12.0f title:@"我们的终点是星辰大海"];
    
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.photoImageView.mas_centerX);
        make.top.equalTo(ws.photoImageView.mas_bottom).offset(5);
        make.height.mas_equalTo(35);
    }];
    [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.photoImageView.mas_centerX);
        make.top.equalTo(ws.userNameLabel.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    self.tableView.tableHeaderView = _tableViewHeaderView;
    
}

- (void)setLableWith:(UILabel *)label fontSize:(CGFloat)fontSize title:(NSString *)title {
    label.font = [UIFont systemFontOfSize:fontSize];
    label.text = title;
    label.alpha = 0.7;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    
}

//下拉变大的效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.view.frame.size.width; //图片宽度
    CGFloat yOffset = scrollView.contentOffset.y; //偏移的Y值
    if (yOffset < 0) { //当向下拉时， y 小于0,
        CGFloat totalOffset = _imageHeight + ABS(yOffset);
        CGFloat f = totalOffset / _imageHeight;
        self.headerBackView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
        //拉伸后的图片的frame应该是同比例缩放;
    }
}


#pragma mark --- UITableViewDeledate  // UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [[_dataSource[indexPath.row] objectForKey:TableViewCellHeight] floatValue];
    return height ? height : 44.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [_dataSource[indexPath.row] objectForKey:TableViewTitle];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *vcName = [_dataSource[indexPath.row] objectForKey:TableViewVC];
    if (vcName) {
        [self toContactVCWithName:vcName];
    }
}

//删除，
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    editingStyle = UITableViewCellEditingStyleDelete; //此处的editingStyle 可等于任意UITableViewCellEditingStyle, 改行代码只在iOS8.0以前版本有作用，也可以不实现；
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED {
//    return @"删除";
//}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        deleteRowAction.backgroundColor = [UIColor magentaColor];
        /*//        更新数据
         [self.dataSourceArray removeObjectAtIndex:indexPath.row];
         //        更新UI
         [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
*/
    }];
    
    //设置收藏按钮
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        collectRowAction.backgroundColor = [UIColor greenColor];
    }];
    
    //设置置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        topRowAction.backgroundColor = [UIColor yellowColor];
        /*[self.dataSourceArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
         NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
         [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
         [_tableView reloadData];
*/
    }];
    

    
    // 设置按钮的背景颜色
//    topRowAction.backgroundColor = [UIColor blueColor];
    
    collectRowAction.backgroundColor = [UIColor grayColor];
    
    return  @[deleteRowAction,collectRowAction,topRowAction];//可以通过调整数组的顺序而改变按钮的排序
    
    
}

- (void)toContactVCWithName:(NSString *)vcName {
    
    Class vcClass = NSClassFromString(vcName);
    UIViewController *vc = [[vcClass alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark --- animtaions
/*
- (void)initScaleLayer {
    //心跳的动画
    //初始化
    CALayer *scaleLayer = [[CALayer alloc] init];
    scaleLayer.backgroundColor = [UIColor blueColor].CGColor;
    scaleLayer.frame = CGRectMake(60, 20 + 100, 50, 50);
    scaleLayer.cornerRadius = 10;
    [self.view.layer addSublayer:scaleLayer];
    //设置动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    //开始动画
    [scaleLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}



- (void)initGroupLayer {
    //初始化
    CALayer *groupLayer = [[CALayer alloc] init];
    groupLayer.frame = CGRectMake(60, 300 + 30, 50, 50);
    groupLayer.cornerRadius = 10;
    groupLayer.backgroundColor = [UIColor magentaColor].CGColor;
    [self.view.layer addSublayer:groupLayer];

    //设定动画细节
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue = @1.5;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 1.0;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:groupLayer.position];

    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(320 - 80,
                                                                  groupLayer.position.y)];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 2;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 2;
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 2;
    groupAnnimation.autoreverses = YES;
    //    groupAnnimation.animations = @[moveAnimation, scaleAnimation, rotateAnimation];
    groupAnnimation.animations = @[moveAnimation, scaleAnimation];

    
    groupAnnimation.repeatCount = MAXFLOAT;
    //开演
    [groupLayer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
}
*/



#pragma mark -- button action  functions



- (void)toExtern:(UIButton *)sender {
    PointsViewController *vc = [[PointsViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}





@end
