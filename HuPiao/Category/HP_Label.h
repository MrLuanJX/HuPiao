//
//  HP_Label.h
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_Label : UILabel

- (CGSize)preferredSizeWithMaxWidth:(CGFloat)maxWidth;

// AttributedString
+ (NSMutableAttributedString*)setUpFirstStr:(NSString *)firstStr FirstColor:(UIColor *)firstColor FirstFont:(UIFont *)firstFont SecondStr:(NSString *)secondStr SecondColor:(UIColor *)secondColor SecondFont:(UIFont *)secondFont;

@end

NS_ASSUME_NONNULL_END
