//
//  HP_DyCell.m
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_DyCell.h"
#import "HP_Label.h"
#import "HPDivisableTool.h"
#import "HP_Utility.h"
#import "GXUpvoteButton.h"

@interface HP_DyCell ()
// 头像
@property (nonatomic , strong) HP_ImageView * avatarImageView;
// 昵称
@property (nonatomic , strong) UIButton * nicknameBtn;
// 时间
@property (nonatomic , strong) UILabel * time;
// 内容
@property (nonatomic , strong) UILabel * linkLabel;

@property (nonatomic , strong) UIView * btmBtnsView;

@property (nonatomic , strong) UIButton * leftBtn;       // 左按钮   GXUpvoteButton

@property (nonatomic , strong) UIButton * midBtn;        // 中按钮

@property (nonatomic , strong) UIButton * rightBtn;      // 右按钮
// 图片
@property (nonatomic , strong) HP_ImageListView * imageListView;

@property (nonatomic , assign) BOOL isCommentCell;

@end

@implementation HP_DyCell


- (void)setDyModel:(HP_DyModel *)dyModel {
    _dyModel = dyModel;
    CGFloat rowHeight = 0;

    // 头像
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:dyModel.user.portrait] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    // 昵称
    [self.nicknameBtn setTitle:dyModel.user.name forState:UIControlStateNormal];
    [self.nicknameBtn sizeToFit];
    if (_nicknameBtn.width > kTextWidth) {
        _nicknameBtn.width = kTextWidth;
    }
    // 时间
    self.time.text = [HP_Utility getMomentTime:dyModel.time];
    [self.time sizeToFit];
    
    CGFloat bottom = self.avatarImageView.bottom + kPaddingValue;
    // 正文
    self.linkLabel.text = dyModel.text;
    [self.linkLabel sizeToFit];
    
    bottom = self.linkLabel.bottom + kPaddingValue;
    // 图片
    _imageListView.moment = dyModel;
    if ([dyModel.pictureList count] > 0) {
        _imageListView.origin = CGPointMake(self.avatarImageView.left, bottom);
        bottom = _imageListView.bottom + kPaddingValue;
    }
  
    self.btmBtnsView.frame = CGRectMake(0, self.imageListView.bottom + HPFit(15), HPScreenW, HPFit(40));
    
    if (self.isCommentCell == YES) {
        rowHeight = bottom;
    } else {
        rowHeight = self.btmBtnsView.bottom;
    }
    
    // 这样做就是起到缓存行高的作用，省去重复计算!!!
    self.dyModel.rowHeight = rowHeight;
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
}

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_DyCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_DyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self configUI];
        
        if ([reuseIdentifier isEqualToString:@"dyCommentCell"]) {
            NSLog(@"评论");
            self.isCommentCell = YES;
            self.btmBtnsView.hidden = YES;
        } else {
            self.isCommentCell = NO;
            self.btmBtnsView.hidden = NO;
        }
        
    }
    return self;
}

- (void) configUI{
    WS(wSelf);
    
    // 头像视图
    _avatarImageView = [[HP_ImageView alloc] initWithFrame:CGRectMake(kBlank, kBlank, kAvatarWidth, kAvatarWidth)];
    [_avatarImageView setClickHandler:^(HP_ImageView *imageView) {
        NSLog(@"点击头像");
//        if ([wSelf.delegate respondsToSelector:@selector(didOperateMoment:operateType:)]) {
//            [wSelf.delegate didOperateMoment:wSelf operateType:MMOperateTypeProfile];
//        }
//        [wSelf resetMenuView];
    }];
    
    [self.contentView addSubview:_avatarImageView];
    
    // 名字视图
    _nicknameBtn = [[UIButton alloc] init];
    _nicknameBtn.frame = CGRectMake(CGRectGetMaxX(_avatarImageView.frame)+HPFit(15), _avatarImageView.top, _nicknameBtn.width, 20);
//    _nicknameBtn.tag = MMOperateTypeProfile;
    _nicknameBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    _nicknameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_nicknameBtn setTitleColor:kHLTextColor forState:UIControlStateNormal];
    [_nicknameBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_nicknameBtn sizeToFit];
    [self.contentView addSubview:_nicknameBtn];
    
    // 时间
    _time = [UILabel new];
    _time.frame = CGRectMake(CGRectGetMinX(_nicknameBtn.frame), CGRectGetMaxY(_nicknameBtn.frame), 0, CGRectGetHeight(_nicknameBtn.frame));
    _time.text = @"2019-06-10 14:20:03";
    _time.textColor = HPUIColorWithRGB(0xC2C2C2, 1.0);
    _time.font = HPFontSize(14);
    _time.numberOfLines = 0;
    [_time sizeToFit];
    [self.contentView addSubview:_time];
    
    // 删除
    _deleteBtn = [UIButton new];
    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"dislikeicon_textpage_night_26x14_"] forState:UIControlStateNormal];
    _deleteBtn.hidden = YES;
    [self.contentView addSubview:_deleteBtn];
    [_deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (self.nicknameBtn.mas_centerY);
        make.right.mas_equalTo (-HPFit(20));
    }];
    
    // 关注
    _careBtn = [UIButton new];
    [_careBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_careBtn setTitleColor:kSetUpCololor(61, 121, 253, 1.0) forState:UIControlStateNormal];
    [_careBtn setTitleColor:HPUIColorWithRGB(0x000000, 0.5) forState:UIControlStateHighlighted];
//    _careBtn.layer.borderColor = kSetUpCololor(61, 121, 253, 1.0).CGColor;
//    _careBtn.layer.borderWidth = 1.0;
//    _careBtn.layer.cornerRadius = 5.0;
    _careBtn.titleLabel.font = HPFontSize(14);
    _careBtn.hidden = YES;
    [_careBtn addTarget:self action:@selector(careAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_careBtn];
    [_careBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (self.nicknameBtn.mas_centerY);
        make.right.mas_equalTo (-HPFit(20));
        make.height.mas_equalTo(HPFit(20));
        make.width.mas_equalTo (HPFit(50));
    }];
    
    // 正文视图 ↓↓
    _linkLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(wSelf.avatarImageView.frame), _avatarImageView.bottom + HPFit(10), HPScreenW - kBlank*2, 999)];
    _linkLabel.text = @"苹果近期在美国最高法院输掉了涉及AppStore的一起诉讼。 新网站页面一个部分的标题是“一家欢迎竞争的商店”。这个页面重点介绍了与苹果内置软件和服务有竞争关系的应用，包括Spotify。开发用于控制设备上瘾和监控屏幕使用时间的应用开发者近期表示，他们认为苹果想要将他们的应用从Apptore中下架，是因为他们的产品与苹果近期推出的ScreenTime功能有竞争关系。苹果在欧盟面临这方面的指控。苹果当时在公告中表示，下架这些应用与隐私保护和信息安全有关，并认为这些开发者滥用了苹果的软件。";
    _linkLabel.numberOfLines = 0;
    _linkLabel.font = HPFontSize(17);
    _linkLabel.backgroundColor = [UIColor whiteColor];
    _linkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_linkLabel sizeToFit];
    [self.contentView addSubview:_linkLabel];
    
    // 图片区
    _imageListView = [[HP_ImageListView alloc] initWithFrame:CGRectZero];
    [_imageListView setSingleTapHandler:^(HP_ImageView *imageView) {
        wSelf.cellImgListBlock(imageView.tag - 1000, wSelf.dyModel);
    }];
    [self.contentView addSubview:_imageListView];
    
    _btmBtnsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageListView.bottom + HPFit(15), HPScreenW, HPFit(40))];
    _btmBtnsView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_btmBtnsView];

    _leftBtn = [UIButton new];
    _leftBtn.backgroundColor = [UIColor whiteColor];
    [_leftBtn setTitle:@"1008" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_leftBtn setImage:[UIImage imageNamed:@"details_like_icon_20x20_"] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"details_like_icon_press_20x20_"] forState:UIControlStateSelected];
    [_leftBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, HPFit(10), 0, 0);
    _leftBtn.titleLabel.font = HPFontSize(13);
    [wSelf.btmBtnsView addSubview:_leftBtn];
    
    _midBtn = [UIButton new];
    _midBtn.backgroundColor = [UIColor whiteColor];
    [_midBtn setTitle:@"31" forState:UIControlStateNormal];
    [_midBtn setImage:[UIImage imageNamed:@"comment_24x24_"] forState:UIControlStateNormal];
    [_midBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _midBtn.titleEdgeInsets = UIEdgeInsetsMake(0, HPFit(10), 0, 0);
    _midBtn.userInteractionEnabled = NO;
    _midBtn.titleLabel.font = _leftBtn.titleLabel.font;
    [wSelf.btmBtnsView addSubview:_midBtn];
    
    _rightBtn = [UIButton new];
    _rightBtn.backgroundColor = [UIColor whiteColor];
    [_rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, HPFit(10), 0, 0);
    _rightBtn.titleLabel.font = _leftBtn.titleLabel.font;
    [_rightBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [wSelf.btmBtnsView addSubview:_rightBtn];
    
    [@[wSelf.leftBtn, wSelf.midBtn, wSelf.rightBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    
    [@[wSelf.leftBtn, wSelf.midBtn, wSelf.rightBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wSelf.btmBtnsView.mas_top);
        make.bottom.mas_equalTo(wSelf.btmBtnsView.mas_bottom).offset(-1);
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.btmBtnsView borderForColor:[UIColor lightGrayColor] borderWidth:1 borderType:UIBorderSideTypeTop];
    [self.careBtn setBorderWithCornerRadius:5.0 borderWidth:1.0 borderColor:kSetUpCololor(61, 121, 253, 1.0) type:UIRectCornerAllCorners];

}

#pragma mark - 点击事件
// 关注
- (void) careAction: (UIButton *) sender {
    NSLog(@"关注");
}

// 点击昵称/查看位置/查看全文|收起/删除动态
- (void)buttonClicked:(UIButton *)sender {
    NSLog(@"点击名称");
    /*
    MMOperateType operateType = sender.tag;
    // 改变背景色
    sender.titleLabel.backgroundColor = kHLBgColor;
    GCD_AFTER(0.3, ^{  // 延迟执行
        sender.titleLabel.backgroundColor = [UIColor clearColor];
        if (operateType == MMOperateTypeFull) {
            _moment.isFullText = !_moment.isFullText;
            [_moment update];
        }
        if ([self.delegate respondsToSelector:@selector(didOperateMoment:operateType:)]) {
            [self.delegate didOperateMoment:self operateType:operateType];
        }
    });
    [self resetMenuView];
     */
}
// 点赞
- (void) likeAction :(UIButton *) sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [HPDivisableTool btnActionAnimationWithBtn:sender FromValue:0.7 ToValue:1.3 Duration:0.2 RepeatCount:1];
        
        [sender setImage:[UIImage imageNamed:@"details_like_icon_press_20x20_"] forState:UIControlStateSelected];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    } else {
        [sender setImage:[UIImage imageNamed:@"details_like_icon_20x20_"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

// 分享
- (void) shareAction:(UIButton *) sender {
    if (self.shareBlock) {
        self.shareBlock();
    }
}

@end

