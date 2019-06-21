//
//  HP_PersonalModel.m
//  HuPiao
//
//  Created by a on 2019/6/21.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_PersonalModel.h"

@implementation HP_PersonalModel

- (CGFloat) getSize {
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, HPFit(20)) options:NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: HPFontSize(14)} context:nil];
    
    rect.size.height += HPFit(10);
    rect.size.width  += rect.size.height *1.5;
    
    return 0;
}

@end
