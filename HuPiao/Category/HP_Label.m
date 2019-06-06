//
//  HP_Label.m
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_Label.h"
//总得有个极限
static CGFloat kMLLabelFloatMax = 10000000.0f;

@implementation HP_Label

- (CGSize)preferredSizeWithMaxWidth:(CGFloat)maxWidth {
    CGSize size = [self sizeThatFits:CGSizeMake(maxWidth, kMLLabelFloatMax)];
    size.width = fmin(size.width, maxWidth); //在numberOfLine为1模式下返回的可能会比maxWidth大，所以这里我们限制下
    return size;
}


@end
