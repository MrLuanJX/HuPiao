//
//  HP_EvaluateTableCell.m
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_EvaluateTableCell.h"

@interface HP_EvaluateTableCell()

@property (nonatomic , strong) UIButton * icon;

@property (nonatomic , strong) UILabel * title;

@property (nonatomic , strong) UIButton * name;

@end

@implementation HP_EvaluateTableCell

- (void)setCommentModel:(HP_CsoCommentLColl *)commentModel {
    _commentModel = commentModel;
    
    [self.icon sd_setBackgroundImageWithURL:[NSURL URLWithString:commentModel.strHardimg] forState:UIControlStateNormal];
    
    self.title.text = commentModel.strLabString;
    
   CGFloat width = [self getWidthWithText:commentModel.strLabString height:HPFit(30) font:15];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (self.icon.mas_centerY);
        make.right.mas_equalTo (-HPFit(10));
        make.height.mas_equalTo(HPFit(30));
        make.width.mas_equalTo (width);
    }];
}

// 创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
    
    HP_EvaluateTableCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_EvaluateTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];//kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
    }
    return self;
}

- (void) setupUI {
    [self.contentView addSubview: self.icon];
    
    [self.contentView addSubview: self.title];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(HPFit(10));
        make.width.height.mas_equalTo (HPFit(40));
    }];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (self.icon.mas_centerY);
        make.right.mas_equalTo (-HPFit(10));
        make.height.mas_equalTo(HPFit(30));
        make.width.mas_equalTo (HPFit(90));
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.icon setBorderWithCornerRadius:self.icon.height/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
    
    [self.title setBorderWithCornerRadius:self.title.height/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        _title.backgroundColor = kSetUpCololor(R, G, B, 1.0);
        
        _title.font = HPFontSize(15);
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = HPUIColorWithRGB(0xffffff, 1.0);
    }
    return _title;
}

- (UIButton *)icon {
    if(!_icon){
        _icon = [UIButton new];
//        _icon.backgroundColor = [UIColor yellowColor];
        _icon.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _icon;
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HPFontSize(font)} context:nil];
    return rect.size.width + HPFit(30);
}

@end
