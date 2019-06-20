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
        
        [self.contentView addSubview:self.bgImg];
                
        [self.bgImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.top.left.mas_equalTo(0);
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

@end
