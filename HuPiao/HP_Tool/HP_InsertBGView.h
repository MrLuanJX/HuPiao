//
//  HP_InsertBGView.h
//  HuPiao
//
//  Created by a on 2019/5/28.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_InsertBGView : UIView

+ (void)addRefreshBGView:(UIView *)BGView ColorArray:(NSArray *)colorArray Locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
