//
//  XZ_CollectionCell.m
//  LJXXZYS
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "XZ_CollectionCell.h"

@interface XZ_CollectionCell()

@end

@implementation XZ_CollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        __weak typeof (self) weakSelf = self;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2.0f;
        
        self.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.bgImg];
        
        [self.contentView addSubview:self.title];
        
        [self.bgImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.top.left.mas_equalTo(0);
        }];
        
        [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
            make.bottom.mas_equalTo(-HPFit(10));
        }];
    }
    return self;
}

- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        [_bgImg setClipsToBounds:YES];
    }
    return _bgImg;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont boldSystemFontOfSize:25];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor whiteColor];
    }
    return _title;
}

@end
