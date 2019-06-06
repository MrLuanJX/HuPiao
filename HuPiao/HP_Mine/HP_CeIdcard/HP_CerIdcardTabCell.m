//
//  HP_CerIdcardTabCell.m
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CerIdcardTabCell.h"

@interface HP_CerIdcardTabCell ()

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *pictrue;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *detailLabel;

@end

@implementation HP_CerIdcardTabCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self createSubviews];
        [self createConstraint];
    }
    return self;
}

#pragma mark - property

-(void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    if (indexPath.section == 0) {
        self.imgView.image = [UIImage imageNamed:@"group4"];
        self.detailLabel.text = @"拍摄正面";
    }else if (indexPath.section == 1) {
        self.imgView.image = [UIImage imageNamed:@"group5"];
        self.detailLabel.text = @"拍摄背面";
    }else if (indexPath.section == 2) {
        self.imgView.image = [UIImage imageNamed:@"group4_2"];
        self.detailLabel.text = @"拍摄手持身份证正面照";
    }
}

//-(void)setModel:(MyCertifIdCardMdoel *)model {
//    _model = model;
//    if (model.card != nil) {
//        self.imgView.hidden = YES;
//        self.detailLabel.hidden = YES;
//        self.pictrue.image = (UIImage *)model.card;
//    }
//}

-(UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = kSetUpCololor(243, 247, 248, 1.0);
        _bgView.layer.cornerRadius = HPFit(8);
    }
    return _bgView;
}

-(UIImageView *)pictrue {
    if (_pictrue == nil) {
        _pictrue = [UIImageView new];
    }
    return _pictrue;
}

-(UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}

-(UILabel *)detailLabel {
    if (_detailLabel == nil) {
        _detailLabel = [UILabel new];
        _detailLabel.font = HPFontSize(16);
        _detailLabel.textColor = HPSubTitleColor;
    }
    return _detailLabel;
}

#pragma mark - private

-(void)createSubviews {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.pictrue];
    [self.bgView addSubview:self.imgView];
    [self.bgView addSubview:self.detailLabel];
}

-(void)createConstraint {
    __weak typeof (self) weakself = self;
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(HPFit(15));
        make.right.mas_equalTo(-HPFit(15));
        make.height.mas_equalTo(HPFit(185));
    }];
    
    [self.pictrue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(50));
        make.centerX.mas_equalTo(weakself.bgView.mas_centerX);
        
    }];
    
    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.imgView.mas_bottom).mas_offset(HPFit(22));
        make.centerX.mas_equalTo(weakself.bgView.mas_centerX);
    }];
}

@end
