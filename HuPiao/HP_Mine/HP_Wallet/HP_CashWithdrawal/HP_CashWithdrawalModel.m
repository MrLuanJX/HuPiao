//
//  HP_CashWithdrawalModel.m
//  HuPiao
//
//  Created by a on 2019/6/12.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CashWithdrawalModel.h"

@implementation HP_CashWithdrawalModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _text = dict[@"text"];
        _index = dict[@"index"];
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
