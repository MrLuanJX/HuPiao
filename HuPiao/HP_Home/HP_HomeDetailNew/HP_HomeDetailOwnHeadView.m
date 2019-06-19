//
//  HP_HomeDetailOwnHeadView.m
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_HomeDetailOwnHeadView.h"

@interface HP_HomeDetailOwnHeadView()

@property (nonatomic , strong) UILabel * nameLabel;                 // 昵称
@property (nonatomic , strong) UILabel * contentLabel;              // 签名
@property (nonatomic , strong) UIButton * careBtn;                  // 收藏
@property (nonatomic , strong) UILabel * btmLine;                   // 线
@property (nonatomic , strong) UIImageView * authImg;               // 认证
@property (nonatomic , strong) YYStarView * starView;               // 五星
@property (nonatomic , strong) UIButton * likeBtn;                  // 热度

@end

@implementation HP_HomeDetailOwnHeadView

- (void)setUser:(MUser *)user {
    
    self.nameLabel.text = user.name;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self createConstrainte];
    }
    return self;
}

- (void) setupUI {
    [self addSubview: self.nameLabel];
    [self addSubview: self.contentLabel];
    [self addSubview: self.btmLine];
//    [self addSubview: self.careBtn];
    [self addSubview: self.authImg];
    [self addSubview: self.starView];
    [self addSubview: self.likeBtn];
    [self addSubview: self.weChatBtn];
}

- (void) createConstrainte {
    WS(wSelf);
    
    [self.authImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(HPFit(20));
        make.top.left.mas_equalTo (HPFit(15));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (wSelf.authImg.mas_right).offset(HPFit(5));
        make.centerY.mas_equalTo (wSelf.authImg.mas_centerY);
    }];
    
    [self.btmLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(HPFit(1));
    }];
    
//    [self.careBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(wSelf.nameLabel.mas_centerY);
//        make.right.mas_equalTo (-HPFit(15));
//        make.width.height.mas_equalTo(HPFit(25));
//    }];
    
    [self.likeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(wSelf.nameLabel.mas_centerY);
        make.right.mas_equalTo (-HPFit(15));
    }];
    
    [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (wSelf.nameLabel.mas_right).offset(HPFit(10));
        make.centerY.mas_equalTo(wSelf.nameLabel.mas_centerY);
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (wSelf.authImg.mas_left);
        make.top.mas_equalTo (wSelf.authImg.mas_bottom).offset(HPFit(10));
        make.right.mas_equalTo (-HPFit(65));
    }];
    
    [self.weChatBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(wSelf.likeBtn.mas_right);
        make.centerY.mas_equalTo (wSelf.contentLabel.mas_centerY);
        make.width.height.mas_equalTo (HPFit(40));
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = HPFontBoldSize(20);
//        _nameLabel.backgroundColor = [UIColor redColor];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *) contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
//        _contentLabel.textColor = kSetUpCololor(185, 185, 185, 1.0);
//        _contentLabel.font = HPFontSize(14);
//        _contentLabel.text = [NSString stringWithFormat:@"%@：%@",@"个性签名",@"不要以为这是👉白浅上神👈，这只是一只可爱的文须雀。"];
        _contentLabel.attributedText = [self setUpmoney:@"Ta 说  " danwei:@"不要以为这是👉白浅上神👈，这只是一只可爱的文须雀。"];
        _contentLabel.numberOfLines = 0;
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

- (UILabel *)btmLine {
    if (!_btmLine) {
        _btmLine = [UILabel new];
        _btmLine.backgroundColor = HPUIColorWithRGB(0xEDEDED, 1.0);
    }
    return _btmLine;
}
/*
- (UIButton *)careBtn {
    if (!_careBtn) {
        _careBtn = [UIButton new];
        [_careBtn setBackgroundImage:[UIImage imageNamed:@"love_video_night_20x20_"] forState:UIControlStateNormal];
        [_careBtn setBackgroundImage:[UIImage imageNamed:@"love_video_press_20x20_"] forState:UIControlStateSelected];
//        [_careBtn setImage:[UIImage imageNamed:@"love_video_night_20x20_"] forState:UIControlStateNormal];
//        [_careBtn setImage:[UIImage imageNamed:@"love_video_press_20x20_"] forState:UIControlStateSelected];
        [_careBtn addTarget:self action:@selector(careAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _careBtn;
}
*/
- (UIImageView *) authImg {
    if (!_authImg) {
        _authImg = [UIImageView new];
        _authImg.image = [UIImage imageNamed:@"all_v_label_star_14x14_"];
    }
    return _authImg;
}

- (YYStarView *)starView {
    if (!_starView) {
        _starView = [YYStarView new];
        _starView.type = StarViewTypeShow;
        _starView.starSpacing = HPFit(1);
        _starView.starScore = 5;
        _starView.starSize = CGSizeMake(20, 20);
        _starView.starBrightImageName = @"star_bright";
    }
    return _starView;
}

/*
 YYStarView *starView = [YYStarView new];
 
 //星的个数，如果不设置，则默认为5颗
 starView.starCount = 7;
 
 //StarView的类型，如果不设置，默认为Select类型
 starView.type = StarViewTypeShow;
 
 //星级评分，如果不设置，默认为0分（一般只有在展示时会设置这个属性）
 starView.starScore = 2;
 
 //星与星之间的间距，如果不设置，则默认为0
 starView.starSpacing = 15;
 
 //每颗星的大小，如果不设置，则按照图片大小自适应
 starView.starSize = CGSizeMake(25, 25);
 
 //亮色星图片名称，如果不设置，则使用默认图片
 starView.starBrightImageName = @"star_bright";
 
 //暗色星图片名称，如果不设置，则使用默认图片
 //如果你需要设置亮星与暗星的高亮图片，也是支持的，你只需要将高亮图片名改为正常图片加后缀"_highlighted"即可
 starView.starDarkImageName = @"star_dark";
 
 //通过属性starScore设置评分
 label.text = starView.starScore;//伪代码
 
 [self.view addSubview:starView];
 [starView mas_makeConstraints:^(MASConstraintMaker *make) {
 //只需设置位置即可，当然，如果你就想设置size也可以，或者不用masonry直接设置frame也可以，需要自己根据图片大小，间距算好size，不然图片会变形哦
 make.left.mas_equalTo(10);
 make.top.mas_equalTo(100);
 }];
 */

- (UIButton *) likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton new];
        [_likeBtn setTitle:[NSString stringWithFormat:@"%u",(arc4random() % 2560)] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"huoshan_tabbar_press_32x32_"] forState:UIControlStateNormal];
        //        [_likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        //        _likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _likeBtn;
}

- (UIButton *) weChatBtn {
    if (!_weChatBtn) {
        _weChatBtn = [UIButton new];
        [_weChatBtn setImage:[UIImage imageNamed:@"weChat"] forState:UIControlStateNormal];
        [_weChatBtn addTarget:self action:@selector(weChatAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weChatBtn;
}

// 微信
- (void) weChatAction {
    if (self.weChatActionBlock) {
        self.weChatActionBlock();
    }
}

// 关注
- (void) careAction : (UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
         NSLog(@"关注");
        [sender setBackgroundImage:[UIImage imageNamed:@"love_video_press_20x20_"] forState:UIControlStateSelected];
    } else {
         NSLog(@"取消关注");
         [sender setBackgroundImage:[UIImage imageNamed:@"love_video_night_20x20_"] forState:UIControlStateNormal];
    }
}

- (NSMutableAttributedString*)setUpmoney:(NSString *)money danwei:(NSString *)danwei{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",money,danwei]];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:HPUIColorWithRGB(0xCD2990, 1.0)
                range:NSMakeRange(0,[money length])];
    [str addAttribute:NSForegroundColorAttributeName
                value:kSetUpCololor(185, 185, 185, 1.0)
                range:NSMakeRange([money length],[danwei length])];
    
    [str addAttribute:NSFontAttributeName
                value:HPFontBoldSize(20)
                range:NSMakeRange(0, [money length])];
    [str addAttribute:NSFontAttributeName
                value:HPFontSize(14)
                range:NSMakeRange([money length], [danwei length])];
    
    
    return str;
}

@end
