//
//  ShopListCell.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/8/5.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "ShopListCell.h"


@interface ShopListCell ()


@end


@implementation ShopListCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI {
    

    self.titleLabel = [UILabel new];
    self.titleLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.titleLabel.layer.borderWidth = 2;
    [self addSubview:_titleLabel];
    
    self.descLable = [UILabel new];
    _descLable.layer.borderColor = [UIColor grayColor].CGColor;
    _descLable.layer.borderWidth = 2;
    [self addSubview:_descLable];
    
    self.typeImageView = [UIImageView new];
    _typeImageView.backgroundColor = [UIColor greenColor];
    [self addSubview:_typeImageView];
    
    
    self.textField = [[JVFloatLabeledTextField alloc] init];
    _textField.placeholder = @"please input something";
    _textField.floatingLabel.text = @"something is about iOS 8.0";
    
    [self addSubview:_textField];
    
    
    //左边距离父视图左边10点
    
    CGFloat padding = 10.0f;
    
    //title距左边和上边都10， 右边也是10
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:padding];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:padding];
    
    //imageview 距右边10，水平居中，
    [_typeImageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:padding];
    [_typeImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];  //水平对齐  centerY
    [_typeImageView autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    [_titleLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:_typeImageView withOffset:-padding];
    [_titleLabel autoSetDimension:ALDimensionHeight toSize:30.0];
    
    
    //desc上边距title10，左边，长，宽与title相同
    [_descLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel withOffset:padding];
    
    
    [_textField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_descLable];
    
    
    [@[_titleLabel, _descLable, _textField] autoAlignViewsToEdge:ALEdgeLeading];
    [@[_titleLabel, _descLable, _textField] autoAlignViewsToAxis:ALAxisVertical];
    [@[_titleLabel, _descLable, _textField] autoMatchViewsDimension:ALDimensionHeight];
    
    
    
    
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
     
     *
     */
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
