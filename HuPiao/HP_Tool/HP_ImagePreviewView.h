//
//  HP_ImagePreviewView.h
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HP_ImagePreviewView : UIView <UIScrollViewDelegate>

// 横向滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;
// 页码指示
@property (nonatomic,strong) UIPageControl *pageControl;
// 页码数目
@property (nonatomic,assign) NSInteger pageNum;
// 页码索引
@property (nonatomic,assign) NSInteger pageIndex;

@end

//### 单个大图显示视图
@interface MMScrollView : UIScrollView <UIScrollViewDelegate>

// 显示的大图
@property (nonatomic,strong) UIImageView *imageView;
// 原始Frame
@property (nonatomic,assign) CGRect originRect;
// 过程Frame
@property (nonatomic,assign) CGRect contentRect;
// 图片
@property (nonatomic,strong) UIImage *image;
// 点击大图(关闭预览)
@property (nonatomic, copy) void (^tapBigView)(MMScrollView *scrollView);
// 长按大图
@property (nonatomic, copy) void (^longPressBigView)(MMScrollView *scrollView);

// 更新Frame
- (void)updateOriginRect;

@end

NS_ASSUME_NONNULL_END
