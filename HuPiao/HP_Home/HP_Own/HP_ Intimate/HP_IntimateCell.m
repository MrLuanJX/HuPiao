//
//  HP_IntimateCell.m
//  HuPiao
//
//  Created by a on 2019/6/21.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_IntimateCell.h"

@interface HP_IntimateCell()

@property (nonatomic , strong) UIImageView * icon;

@property (nonatomic , strong) UILabel * name;

@property (nonatomic , strong) UIImageView * numImg;

@property (nonatomic , strong) UILabel * numLabel;

@property (nonatomic , strong) UIButton * hot;

@end

@implementation HP_IntimateCell

- (void)setCsoGiftModel:(HP_CsoGiftSendMemberColl *)csoGiftModel {
    _csoGiftModel = csoGiftModel;
    
    self.name.text = [NSString stringWithFormat:@"%@",csoGiftModel.strNickName];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:csoGiftModel.strHardimg] placeholderImage:[UIImage imageWithColor:kSetUpCololor(195, 195, 195, 1.0)]];
    
    [self.hot setTitle:[NSString stringWithFormat:@"+%@",csoGiftModel.strBranch] forState:UIControlStateNormal];
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
    
    self.numLabel.text = [NSString stringWithFormat:@"NO.%ld",index.row+1];
    
    if (index.row == 0) {
        self.numLabel.textColor = HPUIColorWithRGB(0xCD2626, 1.0);
    } else if (index.row == 1) {
        self.numLabel.textColor = HPUIColorWithRGB(0xCCCCCC, 1.0);
    } else if (index.row == 2) {
        self.numLabel.textColor = HPUIColorWithRGB(0x8B6914, 1.0);
    }
}

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_IntimateCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_IntimateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];//kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.icon setBorderWithCornerRadius:self.icon.width/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (void) configUI {
    WS(wSelf);
    
    [self.contentView addSubview: self.numLabel];
    [self.contentView addSubview: self.numImg];
    [self.contentView addSubview: self.icon];
    [self.contentView addSubview: self.name];
    [self.contentView addSubview: self.hot];
    
    [self.numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom).offset(-HPFit(10));
        make.left.top.mas_equalTo (HPFit(10));
        make.width.mas_equalTo (HPFit(55));
    }];
    
    [self.numImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom).offset(-HPFit(10));
        make.left.top.mas_equalTo (HPFit(10));
        make.width.mas_equalTo (HPFit(55));
    }];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (HPFit(5));
        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom).offset(-HPFit(5));
        make.left.mas_equalTo (wSelf.numLabel.mas_right).offset(HPFit(5));
        make.width.mas_equalTo (wSelf.icon.mas_height);
    }];
    
    [self.hot mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo (wSelf.numLabel);
        make.right.mas_equalTo (-HPFit(10));
        make.width.mas_equalTo (HPFit(70));
    }];
    
    [self.name mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo (wSelf.numImg);
        make.left.mas_equalTo (wSelf.icon.mas_right).offset (HPFit(5));
        make.right.mas_equalTo (wSelf.hot.mas_left).offset (-HPFit(5));
    }];
}

- (UIImageView *)numImg {
    if (!_numImg) {
        _numImg = [UIImageView new];
        _numImg.backgroundColor = [UIColor redColor];
        _numImg.hidden = YES;
    }
    return _numImg;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.textColor = HPUIColorWithRGB(0x666666, 1.0);
        _numLabel.font = HPFontSize(18);
        [_numLabel sizeToFit];
//        _numLabel.hidden = YES;
    }
    return _numLabel;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [UIImageView new];
//        int R = (arc4random() % 256) ;
//        int G = (arc4random() % 256) ;
//        int B = (arc4random() % 256) ;
//        _icon.backgroundColor = kSetUpCololor(R, G, B, 1.0);
    }
    return _icon;
}

- (UILabel *)name {
    if (!_name) {
        _name = [UILabel new];
        _name.font = HPFontSize(15);
        _name.textColor = HPUIColorWithRGB(0x333333, 1.0);
        _name.text = @"作为智能手机";
    }
    return _name;
}

- (UIButton *)hot {
    if (!_hot) {
        _hot = [UIButton new];
        [_hot setTitleColor:HPUIColorWithRGB(0x32CD32, 1.0) forState:UIControlStateNormal];
        _hot.titleLabel.font = HPFontBoldSize(16);
        _hot.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _hot;
}

@end
