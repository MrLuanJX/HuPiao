//
//  INMUpdateView.m
//  ainanming
//
//  Created by 盛世智源 on 2018/11/14.
//  Copyright © 2018年 陆义金. All rights reserved.
//

#import "INMUpdateView.h"

@interface INMUpdateContentView : UIView<UIScrollViewDelegate>
/* titleMode */
@property (nonatomic , strong) UIView * titleBackView;

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UILabel * versionLabel;
/* contentMode */
@property (nonatomic , strong) UIScrollView * scrollView;

@property (nonatomic , strong) UILabel * contentLabel;

@property (nonatomic , strong) UIButton * updateBtn;

@property (nonatomic , strong) UIButton * cancelBtn;
/* block */
@property (nonatomic , copy) void(^cancelBlock)(void);

@property (nonatomic , copy) void(^contentViewUpdateBlcok)(void);
/* updateModel */
@property (nonatomic , strong) INMUpdateModel * updateModel;

@property (nonatomic , strong) UIView * lineView;

@end

@implementation INMUpdateContentView

+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HPFontSize(font)} context:nil];
    
    return rect.size.height;
}

-(void)setUpdateModel:(INMUpdateModel *)updateModel{
    _updateModel = updateModel;
    
    /* content */
    self.contentLabel.text = self.updateModel.content;
    
    /* versionCode */
    self.versionLabel.text = [NSString stringWithFormat:@"V%@",self.updateModel.versionCode];
    
    /*
     
     self.contentLabel.height = [self.contentLabel heightWithWidth:self.titleBackView.width - INMFit(20)];
     
     self.contentLabel.frame = CGRectMake(0 , 0 , self.titleBackView.width - INMFit(20), self.contentLabel.height);
     
     NSLog(@"%f--%f--%f",self.contentLabel.height , [self superview].height/4, INMFit(100));
     
     self.scrollView.contentSize = CGSizeMake(self.titleBackView.width, self.contentLabel.bottom + INMFit(10));
     
     if ([self superview].height/2 > self.contentLabel.height) {
     [self setNeedsUpdateConstraints];
     [UIView animateWithDuration:0.3 animations:^{
     [self mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.left.mas_equalTo(INMFit(25));
     make.right.mas_equalTo(-INMFit(25));
     make.centerY.mas_equalTo([self superview]);
     make.height.mas_equalTo(INMFit(self.contentLabel.height) + INMFit(40) + INMFit(50) + INMFit(40));
     }];
     [self layoutIfNeeded];
     }];
     //        self.scrollView.scrollEnabled = NO;
     }
     */
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    /* 调整titleView的高度，是否显示version */
    if (HPNULLString(self.updateModel.versionCode)) {
        self.versionLabel.hidden = YES;
        [self.titleBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.width.mas_equalTo(self);
            make.height.mas_equalTo(HPFit(50));
        }];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.titleBackView);
        }];
    }
    /* 根据type判断是否强制更新 */
    if (self.updateModel.type == 0) {
        [self.updateBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(0.5);
            make.top.mas_equalTo(self.lineView.mas_bottom);
        }];
        self.cancelBtn.hidden = NO;
        [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
            make.top.mas_equalTo(self.lineView.mas_bottom);
        }];
    }else{
        self.cancelBtn.hidden = YES;
        [self.updateBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self.lineView.mas_bottom);
        }];
    }
    [self layoutIfNeeded];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    /* titleView */
    UIView * titleBackView = [[UIView alloc]init];
    titleBackView.backgroundColor = HPZHThemeColor;
    [self addSubview:titleBackView];
    [titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.mas_equalTo(self);
        make.height.mas_equalTo(HPFit(60));
    }];
    self.titleBackView = titleBackView;
    /*标题*/
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"发现新版本";
    titleLabel.textColor = HPUIColorWithRGB(0x333333, 1.0);
    titleLabel.font = HPFontBoldSize(19);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleBackView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(titleBackView);
        make.top.mas_equalTo(HPFit(5));
        make.height.mas_equalTo(HPFit(30));
    }];
    self.titleLabel = titleLabel;
    /* version */
    UILabel * versionLabel = [UILabel new];
    versionLabel.textColor = HPUIColorWithRGB(0x666666, 1.0);
    versionLabel.font = HPFontBoldSize(14);
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [titleBackView addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(titleBackView);
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.bottom.mas_equalTo(titleBackView.mas_bottom).offset(-HPFit(5));
    }];
    self.versionLabel = versionLabel;
    
    UIScrollView * backScrollView = [[UIScrollView alloc]init];
    [self addSubview:backScrollView];
    [backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(titleBackView);
        make.top.mas_equalTo(titleBackView.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-HPFit(40));
    }];
    self.scrollView = backScrollView;
    self.scrollView.delegate = self;
    /* backContentView */
    UIView * vibackContentViewew = [[UIView alloc]init];
    [backScrollView addSubview:vibackContentViewew];
    [vibackContentViewew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backScrollView);
        //因为上面的宽高是相对于contentSize的  所以为0  这里需要设置contentView的宽度约束后  scrollView的contentSize.width就会拉伸
        make.width.equalTo(backScrollView);
    }];
    /* 更新内容 */
    UILabel * contentLabel = [[UILabel alloc]init];
    contentLabel.textColor = HPUIColorWithRGB(0x333333, 1.0);
    contentLabel.font = HPFontSize(15);
    contentLabel.numberOfLines = 0;
    [vibackContentViewew addSubview:contentLabel];
    self.contentLabel = contentLabel;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HPFit(10));
        make.left.mas_equalTo(HPFit(10));
        make.top.mas_equalTo(HPFit(20));
        // 必须加上这个约束 这样contentView才能确定scrollerView的contentSize
        make.bottom.mas_equalTo(-HPFit(20));
    }];
    /* 线 */
    UIView * lineView = [UIView new];
    lineView.backgroundColor = HPLineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(titleBackView);
        make.height.mas_equalTo(HPFit(1));
        make.top.mas_equalTo(backScrollView.mas_bottom);
    }];
    self.lineView = lineView;
    /* 更新按钮 */
    UIButton * updateBtn = [UIButton new];
    [updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [updateBtn setTitleColor:HPUIColorWithRGB(0xffffff, 1.0) forState:UIControlStateNormal];
    updateBtn.backgroundColor = HPZHThemeColor;
    [updateBtn addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:updateBtn];
    self.updateBtn = updateBtn;
    /* 取消 */
    UIButton * cancelBtn = [UIButton new];
    [cancelBtn setTitleColor:HPZHThemeColor forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = HPUIColorWithRGB(0xffffff, 1.0);
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
}

#pragma mark - btnAction
-(void)updateAction:(UIButton *)sender{
    if (self.contentViewUpdateBlcok) {
        self.contentViewUpdateBlcok();
    }
}

-(void)cancelAction:(UIButton *)sender{
    if (self.cancelBlock) {
       self.cancelBlock();
    }
}
/* 切圆角 */
-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    
    [self.titleBackView setBorderWithCornerRadius:HPFit(5) borderWidth:0 borderColor:HPClearColor type:UIRectCornerTopRight | UIRectCornerTopLeft];
    
    [self setBorderWithCornerRadius:HPFit(10) borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
    
    if (self.updateModel.type == canCancelType) {
        [self.updateBtn setBorderWithCornerRadius:HPFit(5) borderWidth:0 borderColor:HPClearColor type:UIRectCornerBottomRight];
        [self.cancelBtn setBorderWithCornerRadius:HPFit(5) borderWidth:0 borderColor:HPClearColor type:UIRectCornerBottomLeft];
    }else{
        [self.updateBtn setBorderWithCornerRadius:HPFit(5) borderWidth:0 borderColor:HPClearColor type:UIRectCornerBottomRight | UIRectCornerBottomLeft];
    }
}

@end

@interface INMUpdateView()

/** 视图 */
@property (nonatomic , strong) INMUpdateContentView * updateContentView;

@end

@implementation INMUpdateView

+ (instancetype)showUpdateView{
    return [[self alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        //蒙版遮罩
        UIButton *coverBtn = [[UIButton alloc] init];
        coverBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:(0.6)];
        /* 点击背景收起的话可以实现下面的方法 */
//        [coverBtn addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverBtn];
        [coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        //弹出视图
        INMUpdateContentView * updateContentView = [[INMUpdateContentView alloc]init];
        self.updateContentView = updateContentView;
        [self addSubview:updateContentView];
        [updateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HPFit(25));
            make.right.mas_equalTo(-HPFit(25));
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
        }];
        [self shakeToShow:updateContentView];
    }
    /* 界面需要单独的关闭按钮的 可以单独添加 */
    /*
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"login_close_btn"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    closeBtn.tag = btnTypeClose;
    self.closeBtn = closeBtn;
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(-QDFit(120));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(QDFit(50));
        make.height.mas_equalTo(QDFit(50));
    }];
     */
    return self;
}

- (void)close {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show{
//    [Gloabinfo setStatusBarColor:[UIColor clearColor]];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    
    self.updateContentView.updateModel = self.updateModel;
    __weak typeof(self) weakself = self;
    self.updateContentView.cancelBlock = ^{
        [weakself close];
    };
    
    self.updateContentView.contentViewUpdateBlcok = self.updateBlcok;
    [window addSubview:self];
}

/* 显示提示框的动画 */
- (void)shakeToShow:(UIView*)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2,1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0,1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

@end
