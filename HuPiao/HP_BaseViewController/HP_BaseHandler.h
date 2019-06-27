//
//  HP_BaseHandler.h
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*成功的回调*/
typedef void(^ Success)(id obj);
/*失败的回调*/
typedef void(^ Failed)(id obj);

@interface HP_BaseHandler : NSObject

@end

NS_ASSUME_NONNULL_END
