//
//  INMAlertView.h
//  
//
//  Created by 盛世智源 on 2018/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface INMAlertView : UIView

@property (nonatomic , strong) NSMutableArray * dataArray;

+ (instancetype)showUpdateView;

- (void)show ;

@end

NS_ASSUME_NONNULL_END
