//
//  ShopListViewController.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/28.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopListCell.h"
#import <SVProgressHUD.h>
#import <UIView+Toast.h>
#import "OMGToast.h"
#import "CustomAlertView.h"
#import "MovieListCell.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "Sky_HttpRequest.h"
#import "MovieModel.h"

#import "ContentScrollView.h"
#import "ContentView.h"
#import "rilegouleView.h"
#import "CustomView.h"
#import "ImageContentView.h"
#import "ShowMovieViewController.h"



#define kEveryDay @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=%@&vc=67&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&v=1.8.0&f=iphone"


@interface SDWebImageManager  (cache)


- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url;

@end

@implementation SDWebImageManager (cache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    return ([self.imageCache imageFromMemoryCacheForKey:key] != nil) ?  YES : NO;
}

@end




@interface ShopListViewController ()

@property (nonatomic, strong) NSMutableDictionary *selectDic;
@property (nonatomic, strong) NSMutableArray *dateArray;



@end

@implementation ShopListViewController

#pragma mark ---------- 数据解析 -----------

//懒加载
- (NSMutableDictionary *)selectDic{
    
    if (!_selectDic) {
        
        _selectDic = [[NSMutableDictionary alloc]init];
        
    }
    return _selectDic;
}

- (NSMutableArray *)dateArray{
    
    if (!_dateArray) {
        _dateArray = [[NSMutableArray alloc]init];
    }
    return _dateArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self httpRequest];
    
    [self configUI];
    [self initTouchIDBtn];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)configUI {
    
    
}

- (void)httpRequest {
    NSString *dateString = [self getTodayDate];
    NSString *url = [NSString stringWithFormat:kEveryDay, dateString];
    [Sky_HttpRequest GET:url progress:^(NSProgress *progress) {
        
    } success:^(id response) {
        NSLog(@"%@", response);
        
        NSDictionary *Dic = (NSDictionary *)response;
        NSArray *array = Dic[@"dailyList"];
        for (NSDictionary *dic in array) {
            NSMutableArray *selectArray = [NSMutableArray array];
            NSArray *arr = dic[@"videoList"];
            for (NSDictionary *dic1 in arr) {
                MovieModel *model = [[MovieModel alloc] init];
                [model setValuesForKeysWithDictionary:dic1];
                model.collectionCount = dic1[@"consumption"][@"collectionCount"];
                model.replyCount = dic1[@"consumption"][@"replyCount"];
                model.shareCount = dic1[@"consumption"][@"shareCount"];
                [selectArray addObject:model];
            }
            NSString *date = [[dic[@"date"] stringValue] substringToIndex:10];
            
            [self.selectDic setValue:selectArray forKey:date];
        }

        NSComparisonResult(^priceBlock)(NSString *, NSString *) = ^(NSString *string1, NSString *string2) {
            NSInteger number1 = [string1 integerValue];
            NSInteger number2 = [string2 integerValue];
            if (number1 > number2) {
                return NSOrderedDescending;
            }
            else if (number1 < number2) {
                return NSOrderedAscending;
            }
            else {
                return NSOrderedSame;
            }
        };
        self.dateArray = [[[self.selectDic allKeys] sortedArrayUsingComparator:priceBlock] mutableCopy];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

#pragma mark ---- UITableViewDelegate  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dateArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectDic[self.dateArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (0 == indexPath.row) {
//        ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListCell"];
//        if (!cell) {
//            cell = [[ShopListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopListCell"];
//            cell.titleLabel.text = @"111";
//            cell.descLable.text = @"description";
//        }
//        return cell;
//    }
//    else {
        MovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"v"];
        if (!cell) {
            cell = [[MovieListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieListCell"];
        }
        
        return cell;
    
//    }
}
// 头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *string = self.dateArray[section];
    
    long long int date1 = (long long int)[string intValue];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"MMdd"];
    
    NSString *dateString = [dateFormatter stringFromDate:date2];
    
    return dateString;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

//添加每个cell出现时的3D动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(MovieListCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieModel *model = self.selectDic[self.dateArray[indexPath.section]][indexPath.row];
    
    if (![[SDWebImageManager sharedManager] memoryCachedImageExistsForURL:[NSURL URLWithString:model.coverForDetail]]) {
        
        CATransform3D rotation;//3D旋转
        
        rotation = CATransform3DMakeTranslation(0 ,50 ,20);
        //        rotation = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
        //逆时针旋转
        
        rotation = CATransform3DScale(rotation, 0.9, .9, 1);
        
        rotation.m34 = 1.0/ -600;
        
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        
        cell.layer.transform = rotation;
        
        [UIView beginAnimations:@"rotation" context:NULL];
        //旋转时间
        [UIView setAnimationDuration:0.6];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }
    
    [cell cellOffset];
    cell.model = model;
}


-(void)initTouchIDBtn{
    UIButton *touchIDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    touchIDBtn.frame = CGRectMake(50, 300, 60, 40);
    touchIDBtn.frame = CGRectMake(0, 0, 60, 44);

    [touchIDBtn setTitle:@"指纹" forState:UIControlStateNormal];
    [touchIDBtn setBackgroundColor:[UIColor cyanColor]];
    [touchIDBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [touchIDBtn addTarget:self action:@selector(OnTouchIDBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:touchIDBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:touchIDBtn];
    
}

-(void)OnTouchIDBtn:(UIButton *)sender{
    // iOS 8及以上版本执行-(void)authenticateUser方法，方法自动判断设备是否支持和开启Touch ID
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
//        NSLog(@"你的系统满足条件");
        
        // 判断是否开启指纹验证功能
        LAContext *context = [[LAContext alloc] init];
        // Evaluate: 评估,评价
        // policy: 政策,方法
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
            
            NSLog(@"你的设备开启了指纹验证功能");
            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"利用他解锁(支付)" reply:^(BOOL success, NSError * _Nullable error) {
                
                if (success) {
                    [OMGToast showWithText:@"验证成功"];
                    NSLog(@"验证成功");
                    //验证成功，主线程处理UI
                }
                else {
                    if (error.code == -2) {
                        [OMGToast showWithText:[NSString stringWithFormat:@"用户取消了操作:%@",error]];
                        NSLog(@"用户取消了操作:%@",error);
                    }
                    if (error.code != -2) {
                        [OMGToast showWithText:[NSString stringWithFormat:@"验证失败:%@",error]];
                        NSLog(@"验证失败:%@",error);
                    }
                }
            }];
            
        } else {
            [OMGToast showWithText:@"你的设备没有开启"];
        }
        
    } else {
        [OMGToast showWithText:@"你的系统不满足条件"];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // iOS 8及以上版本执行-(void)authenticateUser方法，方法自动判断设备是否支持和开启Touch ID
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
        NSLog(@"你的系统满足条件");
        
        // 判断是否开启指纹验证功能
        LAContext *context = [[LAContext alloc] init];
        // Evaluate: 评估,评价
        // policy: 政策,方法
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
            NSLog(@"你的设备开启了指纹验证功能");
            
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"利用他解锁(支付)" reply:^(BOOL success, NSError * _Nullable error) {
                
                if (success) {
                    NSLog(@"验证成功");
                    //验证成功，主线程处理UI
                }
                if (error.code == -2) {
                    NSLog(@"用户取消了操作:%@",error);
                }
                
                if (error.code != -2) {
                    NSLog(@"验证失败:%@",error);
                }
                
            }];
            
        } else {
            NSLog(@"你的设备没有开启");
        }
        
    } else {
        NSLog(@"你的系统不满足条件");
    }
}




#pragma mark --- other  function


- (NSString *)getTodayDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate * date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



#pragma mark -- scroll

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showImageAtIndexPath:indexPath];
}


#pragma mark --------- 设置待播放界面 ----------

- (void)showImageAtIndexPath:(NSIndexPath *)indexPath{
    
    _array = _selectDic[_dateArray[indexPath.section]];
    _currentIndexPath = indexPath;
    
    MovieListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    CGFloat y = rect.origin.y;
    
    _rilegoule = [[rilegouleView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) imageArray:_array index:indexPath.row];
    _rilegoule.offsetY = y;
    _rilegoule.animationTrans = cell.picture.transform;
    _rilegoule.animationView.picture.image = cell.picture.image;
    
    _rilegoule.scrollView.delegate = self;
    
    [[self.tableView superview] addSubview:_rilegoule];
    //添加轻扫手势
    UISwipeGestureRecognizer *Swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    
    _rilegoule.contentView.userInteractionEnabled = YES;
    
    Swipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    [_rilegoule.contentView addGestureRecognizer:Swipe];
    
    //添加点击播放手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_rilegoule.scrollView addGestureRecognizer:tap];
    
    [_rilegoule aminmationShow];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_rilegoule.scrollView]) {
        
        for (ImageContentView *subView in scrollView.subviews) {
            
            if ([subView respondsToSelector:@selector(imageOffset)] ) {
                [subView imageOffset];
            }
        }
        
        CGFloat x = _rilegoule.scrollView.contentOffset.x;
        
        CGFloat off = ABS( ((int)x % (int)kWidth) - kWidth/2) /(kWidth/2) + .2;
        
        [UIView animateWithDuration:1.0 animations:^{
            _rilegoule.playView.alpha = off;
            _rilegoule.contentView.titleLabel.alpha = off + 0.3;
            _rilegoule.contentView.littleLabel.alpha = off + 0.3;
            _rilegoule.contentView.lineView.alpha = off + 0.3;
            _rilegoule.contentView.descripLabel.alpha = off + 0.3;
            _rilegoule.contentView.collectionCustom.alpha = off + 0.3;
            _rilegoule.contentView.shareCustom.alpha = off + 0.3;
            _rilegoule.contentView.cacheCustom.alpha = off + 0.3;
            _rilegoule.contentView.replyCustom.alpha = off + 0.3;
            
        }];
        
    } else {
        
        NSArray<MovieListCell *> *array = [self.tableView visibleCells];
        
        [array enumerateObjectsUsingBlock:^(MovieListCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [obj cellOffset];
        }];
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_rilegoule.scrollView]) {
        
        int index = floor((_rilegoule.scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
        
        _rilegoule.scrollView.currentIndex = index;
        
        self.currentIndexPath = [NSIndexPath indexPathForRow:index inSection:self.currentIndexPath.section];
        
        [self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
        
        [self.tableView setNeedsDisplay];
        MovieListCell *cell = [self.tableView cellForRowAtIndexPath:self.currentIndexPath];
        
        [cell cellOffset];
        
        CGRect rect = [cell convertRect:cell.bounds toView:nil];
        _rilegoule.animationTrans = cell.picture.transform;
        _rilegoule.offsetY = rect.origin.y;
        
        MovieModel *model = _array[index];
        
        [_rilegoule.contentView setData:model];
        
        [_rilegoule.animationView.picture setImageWithURL:[NSURL URLWithString: model.coverForDetail]];
        
    }
}

#pragma mark -------------- 平移手势触发事件 -----------

- (void)panAction:(UISwipeGestureRecognizer *)swipe{
    
    [_rilegoule animationDismissUsingCompeteBlock:^{
        
        _rilegoule = nil;
    }];
}

#pragma mark -------------- 点击手势触发事件 -----------

- (void)tapAction{
    
    ShowMovieViewController *playVC = [[ShowMovieViewController alloc]init];
    
    playVC.modelArray = _array;
    
    playVC.index = self.currentIndexPath.row;
    
    [self.navigationController pushViewController:playVC animated:YES];
}


@end
