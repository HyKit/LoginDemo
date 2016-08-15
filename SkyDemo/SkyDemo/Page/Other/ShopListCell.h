//
//  ShopListCell.h
//  SkyDemo
//
//  Created by 何亚慧 on 16/8/5.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JVFloatLabeledTextField.h>




@interface ShopListCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descLable;

@property (nonatomic, strong) UIImageView *typeImageView;


@property (nonatomic, strong) JVFloatLabeledTextField *textField;





/**
 *      // myview左边距离父视图左边 10 点.
 [myview autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10.f];
 
 // myview1顶边距离父视图顶部 10 点.
 [myview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.f];
 
 // myview的左边位于btn的右边 10 点的地方.
 [myview autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:btn withOffset:10.f];
 
 // myview的右边位于btn左边 -10 点的地方, 从右往左、从下往上布局时数值都是负的。
 [myview autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:btn withOffset:-10.f];
 
 // 根据label的固有内容尺寸设置它的尺寸
 [label autoSetDimensionsToSize:CGSizeMake(10.f, 10.f)];
 
 // myview、label、btn水平对齐。（意思就是说只需要设置其中一个的垂直约束（y）即可）（这个可以设置多个view水平对齐）
 [@[myview, label, btn] autoAlignViewsToAxis:ALAxisHorizontal];
 
 //myview，label水平对齐（这个是针对两个view的水平对齐）
 [myview autoAlignAxis:ALAxisHorizontal toSameAxisOfView:label];
 
 // myview顶部距离label的底部 10 点.
 [myview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label withOffset:10.f];
 
 // myview左边紧贴父视图左边
 [myview autoPinEdgeToSuperviewEdge:ALEdgeLeading];
 
 // myview的宽度等于父视图的宽度
 [myview autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
 
 // myview的宽度设置为50
 [myview autoSetDimension:ALDimensionWidth toSize:30];
 
 // myview与label左对齐
 [myview autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:label];
 
 // myview与label水平对齐
 [myview autoAlignAxis:ALAxisHorizontal toSameAxisOfView:label];
 
 //myview右边雨label左边的距离大于等于20
 [myview autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:label withOffset:20.f relation:NSLayoutRelationGreaterThanOrEqual];
 
 //myview和btn同宽(同高也一样)
 [@[myview,btn] autoMatchViewsDimension:ALDimensionWidth];//这种可以设置多个view同宽
 [myview autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:btn];//这种只能设置两个view同宽


 */
@end
