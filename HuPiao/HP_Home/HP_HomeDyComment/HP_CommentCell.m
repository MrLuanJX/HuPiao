//
//  HP_CommentCell.m
//  HuPiao
//
//  Created by a on 2019/6/19.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CommentCell.h"

@interface HP_CommentCell()

@property (nonatomic , strong) UIImageView * icon;

@property (nonatomic , strong) UILabel * userName;

@property (nonatomic , strong) UILabel * time;

@property (nonatomic , strong) UILabel * content;

@end

@implementation HP_CommentCell



//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.icon setBorderWithCornerRadius:self.icon.height/2 borderWidth:0 borderColor:[UIColor clearColor] type:UIRectCornerAllCorners];
}

- (void) setupUI {
    WS(wSelf);
    
    [self.contentView addSubview: self.icon];
    [self.contentView addSubview: self.userName];
    [self.contentView addSubview: self.time];
    [self.contentView addSubview: self.content];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo (HPFit(10));
        make.width.height.mas_equalTo (HPFit(40));
    }];
    
    [self.userName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.icon.mas_top);
        make.left.mas_equalTo (wSelf.icon.mas_right).offset (HPFit(10));
        make.right.mas_equalTo (-HPFit(10));
    }];
    
    [self.time mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo (wSelf.icon.mas_bottom);
        make.left.right.mas_equalTo (wSelf.userName);
    }];
    
    [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.icon.mas_bottom).offset(15);
        make.left.mas_equalTo (wSelf.icon.mas_left);
        make.right.mas_equalTo (wSelf.userName.mas_right);
        
        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom).offset(-HPFit(10));
    }];
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.backgroundColor = [UIColor redColor];
    }
    return _icon;
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [UILabel new];
        _userName.font = HPFontBoldSize(17);
        _userName.textColor = HPUIColorWithRGB(0x333333, 1.0);
        _userName.text = @"zhangsan";
        _userName.preferredMaxLayoutWidth = HPScreenW - HPFit(20);
    }
    return _userName;
}

- (UILabel *)time {
    if (!_time) {
        _time = [UILabel new];
        _time = [UILabel new];
        _time.text = @"2019-06-12 14:23:21";
        _time.textColor = HPUIColorWithRGB(0x999999, 1.0);
        _time.font = HPFontSize(12);
        _time.preferredMaxLayoutWidth = HPScreenW - HPFit(20);
    }
    return _time;
}

- (UILabel *)content {
    if (!_content) {
        _content = [UILabel new];
        _content.textColor = HPUIColorWithRGB(0x333333, 1.0);
        _content.font = HPFontSize(15);
        _content.numberOfLines = 0;
        _content.preferredMaxLayoutWidth = HPScreenW - HPFit(20);
    }
    return _content;
    
}

@end
