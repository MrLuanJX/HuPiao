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

@interface DetailCollectCell()

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic , assign) CGFloat itemW;

@property (nonatomic , assign) CGFloat itemH;

@end

@implementation DetailCollectCell

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    
    [self.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        if (self.dataArray.count == 2 || self.dataArray.count == 4) {
            make.height.width.mas_equalTo((HPScreenW - HPFit(40))/2);
        } else {
            make.height.width.mas_equalTo((HPScreenW - HPFit(40))/3);
        }
    }];
    /*
     else if (self.dataArray.count == 1 ) {
     UIImage * animage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=239815455,722413567&fm=26&gp=0.jpg"]]];
     CGFloat imageW = (CGFloat)animage.size.width;
     CGFloat imageH = (CGFloat)animage.size.height;
     CGSize size = CGSizeMake(imageW, imageH);
     CGSize imageSize = [HP_Utility getMomentImageSize:size];
     make.width.mas_equalTo(imageSize.width);
     make.height.mas_equalTo(imageSize.height);
     }
     */
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupItemUI];
    }
    return self;
}

-(void)setupItemUI{
    
    self.image = [UIImageView new];
    self.image.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.image];
}

-(void)setImageData:(NSString *)imageData{
    _imageData = imageData;
    
    self.image.image = [UIImage imageNamed:imageData];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.image setBorderWithCornerRadius:8.0f borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
}

@end

@interface HP_DyCell () <UICollectionViewDelegate,UICollectionViewDataSource>
// 头像
@property (nonatomic , strong) HP_ImageView * avatarImageView;
// 昵称
@property (nonatomic , strong) UIButton * nicknameBtn;
// 时间
@property (nonatomic , strong) UILabel * time;
// 内容
@property (nonatomic , strong) UILabel * linkLabel;
// 图片
@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) UIView * btmBtnsView;
// 图片数组
@property (nonatomic , strong) NSMutableArray * images;

@property (nonatomic , strong) UIButton * leftBtn;       // 左按钮   GXUpvoteButton

@property (nonatomic , strong) UIButton * midBtn;        // 中按钮

@property (nonatomic , strong) UIButton * rightBtn;      // 右按钮
@property (nonatomic , strong) UICollectionViewFlowLayout * layout;

@property (nonatomic , assign) CGFloat itemW;
@property (nonatomic , assign) CGFloat itemH;

@property (nonatomic , strong) UIImageView * seletedImg;


@end

@implementation HP_DyCell

- (void)setUser:(MUser *)user {
    _user = user;

    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.portrait] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    [self.nicknameBtn setTitle:HPNULLString(user.name) ? @"安心" : user.name forState:UIControlStateNormal];
    [self.nicknameBtn sizeToFit];
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
   /*
    else  if (index.row %3 == 0) {
    self.images = [NSMutableArray arrayWithObjects:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=239815455,722413567&fm=26&gp=0.jpg", nil];
    UIImage * animage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=239815455,722413567&fm=26&gp=0.jpg"]]];
    CGFloat imageW = (CGFloat)animage.size.width;
    CGFloat imageH = (CGFloat)animage.size.height;
    CGSize size = CGSizeMake(imageW, imageH);
    CGSize imageSize = [HP_Utility getMomentImageSize:size];
    self.itemW = imageSize.width;
    self.itemH = imageSize.height;
    }
    */
    if (index.row %2 == 0) {
        self.itemW = (HPScreenW - HPFit(40))/2;
        self.itemH = (HPScreenW - HPFit(40))/2;
        self.images = [NSMutableArray arrayWithObjects:@"undrawBabyJa7A",@"undrawBackToSchoolInwc",@"undrawHouseSearchingN8Mp",@"undrawMakeItRainIwk4", nil];
    } else {
        self.itemW = (HPScreenW - HPFit(40))/3;
        self.itemH = (HPScreenW - HPFit(40))/3;
        self.images = [NSMutableArray arrayWithObjects:@"undrawBabyJa7A",@"undrawBackToSchoolInwc",@"undrawHouseSearchingN8Mp",@"undrawMakeItRainIwk4",@"undrawBabyJa7A",@"undrawBackToSchoolInwc",@"undrawHouseSearchingN8Mp",@"undrawMakeItRainIwk4",@"undrawMakeItRainIwk4", nil];
    }
    
    CGFloat h = [self HeightWithDataArr:self.images];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.linkLabel.mas_bottom).offset(HPFit(15));
        make.left.mas_equalTo(self.avatarImageView.mas_left);
        make.right.mas_equalTo(self.contentView).offset(-kBlank);
        make.height.mas_equalTo(@(h));
    }];
    /*
    if (index.row%3 == 0) {
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.linkLabel.mas_bottom).offset(HPFit(15));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(self.itemW);
            make.height.mas_equalTo(self.itemH);
        }];
    } else {
        CGFloat h = [self HeightWithDataArr:self.images];
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.linkLabel.mas_bottom).offset(HPFit(15));
            make.left.mas_equalTo(self.avatarImageView.mas_left);
            make.right.mas_equalTo(self.contentView).offset(-kBlank);
            make.height.mas_equalTo(@(h));
        }];
    }
     */
    [self.collectionView reloadData];
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
    }
    return self;
}

- (void) configUI{
    WS(wSelf);
    
    CGFloat btmHeight;
    
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
    
    btmHeight = _avatarImageView.bottom + HPFit(15);

    // 名字视图
    _nicknameBtn = [[UIButton alloc] init];
    _nicknameBtn.frame = CGRectMake(CGRectGetMaxX(_avatarImageView.frame)+HPFit(15), _avatarImageView.top, _nicknameBtn.width, 20);
//    _nicknameBtn.tag = MMOperateTypeProfile;
    _nicknameBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
//    [_nicknameBtn setTitle:@"寒意" forState:UIControlStateNormal];
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
    // 正文视图 ↓↓
    _linkLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(wSelf.avatarImageView.frame), _avatarImageView.bottom + HPFit(10), HPScreenW - kBlank*2, 999)];
    _linkLabel.text = @"苹果近期在美国最高法院输掉了涉及AppStore的一起诉讼。 新网站页面一个部分的标题是“一家欢迎竞争的商店”。这个页面重点介绍了与苹果内置软件和服务有竞争关系的应用，包括Spotify。开发用于控制设备上瘾和监控屏幕使用时间的应用开发者近期表示，他们认为苹果想要将他们的应用从Apptore中下架，是因为他们的产品与苹果近期推出的ScreenTime功能有竞争关系。苹果在欧盟面临这方面的指控。苹果当时在公告中表示，下架这些应用与隐私保护和信息安全有关，并认为这些开发者滥用了苹果的软件。";
    _linkLabel.numberOfLines = 0;
    _linkLabel.font = HPFontSize(17);
    _linkLabel.backgroundColor = [UIColor whiteColor];
    _linkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_linkLabel sizeToFit];
    [self.contentView addSubview:_linkLabel];
    
    btmHeight = btmHeight + _linkLabel.bottom + HPFit(15);
    
    [self.contentView addSubview:self.collectionView];
    // 计算collect高度
    CGFloat h = [self HeightWithDataArr:self.images];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wSelf.linkLabel.mas_bottom).offset(HPFit(15));
        make.left.mas_equalTo(wSelf.avatarImageView.mas_left);
        make.right.mas_equalTo(wSelf.contentView).offset(-kBlank);
        make.height.mas_equalTo(@(h));
    }];
    
    btmHeight = btmHeight + self.collectionView.bottom + HPFit(15);
    
    _btmBtnsView = [UIView new];
    _btmBtnsView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_btmBtnsView];
    [_btmBtnsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wSelf.collectionView.mas_bottom).offset(HPFit(15));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(HPFit(40));
    }];
    
    _leftBtn = [UIButton new];
    _leftBtn.backgroundColor = [UIColor whiteColor];
    [_leftBtn setTitle:@"1008" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_leftBtn setImage:[UIImage imageNamed:@"details_like_icon_20x20_"] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"details_like_icon_press_20x20_"] forState:UIControlStateSelected];
    [_leftBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    [wSelf.btmBtnsView addSubview:_leftBtn];
    
    _midBtn = [UIButton new];
    _midBtn.backgroundColor = [UIColor whiteColor];
    [_midBtn setTitle:@"31" forState:UIControlStateNormal];
    [_midBtn setImage:[UIImage imageNamed:@"comment_night_24x24_"] forState:UIControlStateNormal];
    [_midBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wSelf.btmBtnsView addSubview:_midBtn];
    
    _rightBtn = [UIButton new];
    _rightBtn.backgroundColor = [UIColor whiteColor];
    [_rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:@"repost_video_20x20_"] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wSelf.btmBtnsView addSubview:_rightBtn];
    
//    NSInteger padding = 10;
    [@[wSelf.leftBtn, wSelf.midBtn, wSelf.rightBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    
    [@[wSelf.leftBtn, wSelf.midBtn, wSelf.rightBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wSelf.btmBtnsView.mas_top);
        make.bottom.mas_equalTo(wSelf.btmBtnsView.mas_bottom).offset(-1);
    }];
    
    btmHeight = btmHeight + _btmBtnsView.bottom + HPFit(15);
    
    if (self.cellHeightBlock) {
        self.cellHeightBlock(btmHeight);
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.btmBtnsView borderForColor:[UIColor lightGrayColor] borderWidth:1 borderType:UIBorderSideTypeTop];
}

#pragma mark - 点击事件
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

#pragma mark ====== UICollectionViewDelegate ======
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.images.count > 0) {
        return self.images.count;
    }else
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailCollectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCollectCell" forIndexPath:indexPath];
    
    if (self.images.count > 0) {
        cell.dataArray = self.images;
       
        cell.imageData = self.images[indexPath.item];
    }
    
    return cell;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.itemW, self.itemH);
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

/* 计算collection高度 */
-(CGFloat)HeightWithDataArr:(NSMutableArray *)dataArray{
    int count = dataArray.count == 4 || dataArray.count == 2 ? 2 : 3;
    
    HPDivisableTool * divisibleTool = [HPDivisableTool new];
    BOOL isDivisible = [divisibleTool judgeDivisibleWithFirstNumber:dataArray.count andSecondNumber:count];
    int bankCount = (int)floor(dataArray.count/count);
    if (isDivisible == NO) {
        if (bankCount <= 0) {
            bankCount = 1;
        }else
            bankCount += 1;
    }
    CGFloat height;
    if (count == 2) {
        height = (HPScreenW - HPFit(40))/2 * bankCount + HPFit(15) * (bankCount - 1);
    } else {
        height = (HPScreenW - HPFit(40))/3 * bankCount + HPFit(15) * (bankCount - 1);
    }
    
    NSUserDefaults * collectHeightDef = [NSUserDefaults standardUserDefaults];
    [collectHeightDef setFloat:height forKey:@"collectHeight"];
    [collectHeightDef synchronize];
    return [[collectHeightDef objectForKey:@"collectHeight"] floatValue];
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionInset = UIEdgeInsetsMake( 0, 0, HPFit(15), 0);
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 行间距
        layout.minimumLineSpacing = HPFit(15);
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[DetailCollectCell class] forCellWithReuseIdentifier:@"detailCollectCell"]; // 注册 cell
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (void) likeAction :(UIButton *) sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [HPDivisableTool btnActionAnimationWithBtn:sender];
        
        [sender setImage:[UIImage imageNamed:@"details_like_icon_press_20x20_"] forState:UIControlStateSelected];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    } else {
        [sender setImage:[UIImage imageNamed:@"details_like_icon_20x20_"] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}



@end

