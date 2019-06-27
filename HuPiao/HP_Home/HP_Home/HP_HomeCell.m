//
//  HP_HomeCell.m
//  HuPiao
//
//  Created by a on 2019/5/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_HomeCell.h"

@interface HP_HomeCell()
    
@property (nonatomic , strong) UIImageView * iconImg;

@property (nonatomic , strong) UIImageView * authImg;

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UILabel * addressLabel;

@property (nonatomic , strong) UIButton * likeBtn;

@property (nonatomic , assign) BOOL isLiked;

@property (nonatomic , strong) YYStarView * starView;               // 五星

@end

@implementation HP_HomeCell

- (void)setUser:(MUser *)user {
    _user = user;
       
    self.titleLabel.text = user.name;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:user.portrait] placeholderImage:[UIImage imageNamed:@""]]; // 1.jpg
}

- (void)setAddress:(NSString *)address {
    _address = address;
    
    self.addressLabel.text = HPNULLString(address) ? self.index.section%3 == 0 ? @"距您 2km" : @"北京市 朝阳区" : address;
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
    
//    self.authImg.hidden = index.row%3 == 0 ? YES : NO;
//    self.titleLabel.text = [NSString stringWithFormat:@"第%ld位昵称",index.row + 1];
}
    
//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[HP_HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}
    
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.isLiked = YES;
        
        [self setupUI];
        [self createConstrainte];
    }
    return self;
}
    
- (void) setupUI {
    [self.contentView addSubview: self.iconImg];
    [self.contentView addSubview: self.authImg];
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.addressLabel];
    [self.contentView addSubview: self.likeBtn];
    [self.contentView addSubview: self.starView];
}
    
- (void)createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    CGFloat wid = [UIScreen mainScreen].bounds.size.width;
    
//    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(-10);
//    }];
    
    [self.iconImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(wid/1.5);
        make.bottom.mas_equalTo (weakSelf.contentView.mas_bottom);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HPFit(10));
        make.bottom.mas_equalTo(-HPFit(40));
    }];
    
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (weakSelf.titleLabel.mas_left);
        make.bottom.mas_equalTo(-HPFit(10));
    }];
    
    [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (weakSelf.titleLabel.mas_right).offset(HPFit(10));
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
    }];
    
    [self.authImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo (-10);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    
    [self.likeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo (-10);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(weakSelf.addressLabel.mas_centerY);
    }];
     
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        _iconImg.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        _iconImg.image = [UIImage imageNamed:@"1.jpg"];
    }
    return _iconImg;
}
    
- (UIImageView *) authImg {
    if (!_authImg) {
        _authImg = [UIImageView new];
        _authImg.image = [UIImage imageNamed:@"gfrz"];
        _authImg.contentMode = UIViewContentModeScaleToFill;
    }
    return _authImg;
}
    
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = HPFontBoldSize(18);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
    }
    return _titleLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = HPFontSize(15);
        _addressLabel.textColor = [UIColor whiteColor];
    }
    return _addressLabel;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton new];
        [_likeBtn setTitle:[NSString stringWithFormat:@"%u",(arc4random() % 2560)] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"huoshan_tabbar_press_32x32_"] forState:UIControlStateNormal];
//        [_likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
//        _likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _likeBtn;
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

- (void) likeAction: (UIButton *) sender {
    NSLog(@"--------action");
    
    if (self.likeBtnActionBlock) {
        self.likeBtnActionBlock(sender);
    }
    
    if (self.isLiked == YES) {
        [sender setImage:[UIImage imageNamed:@"details_like_icon_press_20x20_"] forState:UIControlStateNormal];
        [sender setTitle:@"103" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [HPDivisableTool btnActionAnimationWithBtn:sender FromValue:0.7 ToValue:1.3 Duration:0.2 RepeatCount:1];
        
        self.isLiked = NO;
    } else {
        [_likeBtn setImage:[UIImage imageNamed:@"details_like_icon_20x20_"] forState:UIControlStateNormal];
        [sender setTitle:@"102" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        self.isLiked = YES;
    }
}
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
    
@end
