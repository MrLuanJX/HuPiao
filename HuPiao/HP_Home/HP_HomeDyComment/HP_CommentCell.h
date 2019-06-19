//
//  HP_CommentCell.h
//  DJZJ
//
//  Created by a on 2019/6/14.
//  Copyright © 2019 a. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_CommentCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@end

NS_ASSUME_NONNULL_END
