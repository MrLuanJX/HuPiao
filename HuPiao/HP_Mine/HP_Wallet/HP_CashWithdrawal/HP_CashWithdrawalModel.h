//
//  HP_CashWithdrawalModel.h
//  HuPiao
//
//  Created by a on 2019/6/12.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_CashWithdrawalModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSIndexPath *index;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
