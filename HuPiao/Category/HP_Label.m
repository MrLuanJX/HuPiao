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


+ (NSMutableAttributedString*)setUpFirstStr:(NSString *)firstStr FirstColor:(UIColor *)firstColor FirstFont:(UIFont *)firstFont SecondStr:(NSString *)secondStr SecondColor:(UIColor *)secondColor SecondFont:(UIFont *)secondFont {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",firstStr,secondStr]];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:firstColor
                range:NSMakeRange(0,[firstStr length])];
    [str addAttribute:NSForegroundColorAttributeName
                value:secondColor
                range:NSMakeRange([firstStr length],[secondStr length])];
    
    [str addAttribute:NSFontAttributeName
                value:firstFont
                range:NSMakeRange(0, [firstStr length])];
    [str addAttribute:NSFontAttributeName
                value:secondFont
                range:NSMakeRange([firstStr length], [secondStr length])];
    
    
    return str;
}


@end
