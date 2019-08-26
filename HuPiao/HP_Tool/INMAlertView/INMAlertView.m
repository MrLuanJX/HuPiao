//
//  INMAlertView.m
//  
//
//  Created by 盛世智源 on 2018/11/30.
//

#import "INMAlertView.h"
#import <StoreKit/StoreKit.h>

typedef NS_ENUM(NSUInteger, BtnType) {
    btnTypeStar = 0,                // 五星好评
    btnTypeAppStore = 1,            // 跳转appstore
    btnTypeClose = 2,               // 点关闭按钮
};

typedef void(^ButtonActionBlock) (UIButton *button);

@interface INMAlertContentView : UIView

@property (nonatomic , strong) UILabel * lineLabel;

@property (nonatomic , strong) NSMutableArray * btnTitleArr;
/** 点击按钮回调 */
@property (copy, nonatomic)  ButtonActionBlock buttonActionBlock;

@end

@implementation INMAlertContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = HPFit(10);
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews{
    __weak typeof (self) weakSelf = self;
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = @"我们拼了命加班，只希望您能用的爽。给个五星好评吧亲!";
    titleLabel.font = HPFontBoldSize(17);
    titleLabel.textColor = HPUIColorWithRGB(0x000000, 1.0);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 2;
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(HPFit(10));
        make.right.mas_equalTo(-HPFit(10));
        make.height.mas_equalTo(HPFit(60));
    }];
    
    UILabel * lineLabel = [UILabel new];
    lineLabel.backgroundColor = HPLineColor;
    [self addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(HPFit(10));
        make.height.mas_equalTo(HPFit(1));
    }];
    
    self.lineLabel = lineLabel;
}

-(void)setBtnTitleArr:(NSMutableArray *)btnTitleArr{
    _btnTitleArr = btnTitleArr;
     __weak typeof (self) weakSelf = self;
    
    for (int i = 0; i < self.btnTitleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        btn.titleLabel.font = HPFontBoldSize(17.0);
        [btn setTitleColor:kSetUpCololor(61, 121, 253, 1.0) forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@",self.btnTitleArr[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.lineLabel.mas_bottom).offset(HPFit(50)* i);
            make.right.left.mas_equalTo(weakSelf);
            make.height.mas_equalTo(HPFit(50));
        }];
        if (i < self.btnTitleArr.count - 1) {
            [btn setTitleColor:HPUIColorWithRGB(0x42a7ff, 1.0) forState:UIControlStateNormal];

            UILabel * btnLineLabel = [UILabel new];
            btnLineLabel.backgroundColor = HPLineColor;
            [self addSubview:btnLineLabel];
            [btnLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(btn.mas_bottom);
                make.left.right.mas_equalTo(weakSelf);
                make.height.mas_equalTo(HPFit(1));
            }];
        }
    }
}

-(void)btnClick:(UIButton *)sender{
    if (self.buttonActionBlock) {
        self.buttonActionBlock(sender);
    }
}

@end

@interface INMAlertView()

/** 视图 */
@property (nonatomic , strong) INMAlertContentView * alertContentView;

@end

@implementation INMAlertView

+ (instancetype)showUpdateView{
    return [[self alloc] init];
}

- (instancetype)init{
    if (self = [super init]) {
        __weak typeof (self) weakSelf = self;
        //蒙版遮罩
        UIButton *coverBtn = [[UIButton alloc] init];
        coverBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:(0.6)];
        [self addSubview:coverBtn];
        [coverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        
        //弹出视图
        INMAlertContentView * alertContentView = [[INMAlertContentView alloc]init];
        alertContentView.btnTitleArr = self.dataArray;
        self.alertContentView = alertContentView;
        [self addSubview:alertContentView];
        
        [self shakeToShow:alertContentView];
        
        alertContentView.buttonActionBlock = ^(UIButton *button) {
            if (button.tag == btnTypeStar) {
                [self appScore];
            } else if (button.tag == btnTypeAppStore) {
                [self toAppStoreScoreWithClose:YES];
            } else {
                [self close];
            }
        };
    }
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
    __weak typeof (self) weakSelf = self;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    
    self.alertContentView.btnTitleArr = self.dataArray;
    
    [self.alertContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HPFit(50));
        make.right.mas_equalTo(-HPFit(50));
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(HPFit(50) * weakSelf.dataArray.count + HPFit(80));
    }];
    
    [window addSubview:self];
}

-(void)appScore{
    [self close];
    
    if (@available(iOS 10.3, *)) {
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
            [SKStoreReviewController requestReview];
        }else{
            [self toAppStoreScoreWithClose:NO];
        }
    } else {
        [self toAppStoreScoreWithClose:NO];
    }
}

-(void)toAppStoreScoreWithClose:(BOOL)close{
    if (close) {
        [self close];
    }
    NSString  * nsStringToOpen = [NSString  stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",@"1470596959"];//替换为对应的APPID
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
}
//  https://itunes.apple.com/app/id1470596959
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

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
