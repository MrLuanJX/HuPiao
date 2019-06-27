//
//  HP_ImageListView.m
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_ImageListView.h"
#import "HP_ImagePreviewView.h"
#import "HP_Utility.h"

#pragma mark - ------------------ 小图List显示视图 ------------------

@interface HP_ImageListView ()

// 图片视图数组
@property (nonatomic, strong) NSMutableArray * imageViewsArray;
// 预览视图
@property (nonatomic, strong) HP_ImagePreviewView * previewView;

@end

@implementation HP_ImageListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 小图(九宫格)
        _imageViewsArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            HP_ImageView * imageView = [[HP_ImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 1000 + i;
            [imageView setClickHandler:^(HP_ImageView *imageView){
                [self singleTapSmallViewCallback:imageView];
                if (self.singleTapHandler) {
                    self.singleTapHandler(imageView);
                }
            }];
            [_imageViewsArray addObject:imageView];
            [self addSubview:imageView];
        }
        // 预览视图
        _previewView = [[HP_ImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

#pragma mark - Setter

- (void)setMoment:(HP_DyModel *)moment
{
    _moment = moment;
    for (HP_ImageView * imageView in _imageViewsArray) {
        imageView.hidden = YES;
    }
    // 图片区
    NSInteger count = [moment.pictureList count];
    if (count == 0) {
        self.size = CGSizeZero;
        return;
    }
    // 更新视图数据
    _previewView.pageNum = count;
    _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
    // 添加图片
    HP_ImageView * imageView = nil;
    for (NSInteger i = 0; i < count; i++)
    {
        CGFloat imageX = 0;
        CGFloat imageY = 0;
        CGRect frame = CGRectZero;
        NSInteger rowNum = i / 3;
        NSInteger colNum = i % 3;
        if(count == 4 || count == 2) {
            rowNum = i / 2;
            colNum = i % 2;
            imageY = rowNum * ((HPScreenW- HPFit(30))/2 + HPFit(5));
            imageX = colNum * ((HPScreenW- HPFit(30))/2 + HPFit(5));
            frame = CGRectMake(imageX, imageY, (HPScreenW- HPFit(30))/2 , (HPScreenW- HPFit(30))/2);
        } else {
            imageY = rowNum * ((HPScreenW- HPFit(40))/3 + HPFit(5));
            imageX = colNum * ((HPScreenW- HPFit(40))/3 + HPFit(5));
            frame = CGRectMake(imageX, imageY, (HPScreenW- HPFit(40))/3 , (HPScreenW- HPFit(40))/3);
        }
        // 单张图片需计算实际显示size
        if (count == 1) {
            CGSize singleSize = [HP_Utility getMomentImageSize:CGSizeMake(moment.singleWidth, moment.singleHeight)];
            frame = CGRectMake(0, 0, singleSize.width - 15, singleSize.height);
        }
        imageView = [self viewWithTag:1000+i];
        imageView.hidden = NO;
        imageView.frame = frame;
        // 赋值
        MPicture * picture = [moment.pictureList objectAtIndex:i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:picture.thumbnail]
                     placeholderImage:nil];
    }
    self.width = kTextWidth;
    self.height = imageView.bottom;
}

#pragma mark - 小图单击
- (void)singleTapSmallViewCallback:(HP_ImageView *)imageView {

    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    // 解除隐藏
    [window addSubview:_previewView];
    [window bringSubviewToFront:_previewView];
    // 清空
    [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加子视图
    NSInteger index = imageView.tag - 1000;
    NSInteger count = [_moment.pictureList count];
    CGRect convertRect;
    if (count == 1) {
        [_previewView.pageControl removeFromSuperview];
    }
    for (NSInteger i = 0; i < count; i ++)
    {
        // 转换Frame
        HP_ImageView *pImageView = (HP_ImageView *)[self viewWithTag:1000+i];
        convertRect = [[pImageView superview] convertRect:pImageView.frame toView:window];
        // 添加
        MMScrollView *scrollView = [[MMScrollView alloc] initWithFrame:CGRectMake(i*_previewView.width, 0, _previewView.width, _previewView.height)];
        scrollView.tag = 100+i;
        scrollView.maximumZoomScale = 2.0;
        scrollView.image = pImageView.image;
        scrollView.contentRect = convertRect;
        // 单击
        [scrollView setTapBigView:^(MMScrollView *scrollView){
            [self singleTapBigViewCallback:scrollView];
        }];
        // 长按
        [scrollView setLongPressBigView:^(MMScrollView *scrollView){
            [self longPresssBigViewCallback:scrollView];
        }];
        [_previewView.scrollView addSubview:scrollView];
        if (i == index) {
            [UIView animateWithDuration:0.3 animations:^{
                _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
                _previewView.pageControl.hidden = NO;
                [scrollView updateOriginRect];
            }];
        } else {
            [scrollView updateOriginRect];
        }
    }
    // 更新offset
    CGPoint offset = _previewView.scrollView.contentOffset;
    offset.x = index * HPScreenW;
    _previewView.scrollView.contentOffset = offset;
}

#pragma mark - 大图单击||长按
- (void)singleTapBigViewCallback:(MMScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _previewView.pageControl.hidden = YES;
        scrollView.contentRect = scrollView.contentRect;
        scrollView.zoomScale = 1.0;
    } completion:^(BOOL finished) {
        [_previewView removeFromSuperview];
    }];
}

- (void)longPresssBigViewCallback:(MMScrollView *)scrollView {
    
}

@end

#pragma mark - ------------------ 单个小图显示视图 ------------------
@implementation HP_ImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds  = YES;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)singleTapGestureCallback:(UIGestureRecognizer *)gesture {
    if (self.clickHandler) {
        self.clickHandler(self);
    }
}

@end
