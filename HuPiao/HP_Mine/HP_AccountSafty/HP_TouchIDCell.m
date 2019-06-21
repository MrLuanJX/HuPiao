//
//  HP_TouchIDCell.m
//  HuPiao
//
//  Created by a on 2019/6/21.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_TouchIDCell.h"

@interface HP_TouchIDCell ()

@property (nonatomic , strong) UISwitch * touchIDSwitch;

@end

@implementation HP_TouchIDCell

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_TouchIDCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_TouchIDCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
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

- (void) configUI {
    WS(wSelf);
    
    [self.contentView addSubview: self.title];
    [self.contentView addSubview: self.touchIDSwitch];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (HPFit(10));
        make.left.mas_equalTo (15);
        make.bottom.mas_equalTo (-HPFit(10));
    }];
    
    [self.touchIDSwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo (-HPFit(10));
        make.centerY.mas_equalTo (wSelf.title.mas_centerY);
    }];
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = [UIColor blackColor];//HPUIColorWithRGB(0x333333, 1.0);
        _title.font = [UIFont systemFontOfSize:17];//HPFontSize(16);
        [_title sizeToFit];
    }
    return _title;
}

- (UISwitch *)touchIDSwitch {
    if (!_touchIDSwitch) {
        _touchIDSwitch = [UISwitch new];
        _touchIDSwitch.onTintColor = kSetUpCololor(61, 121, 253, 1.0);
        [_touchIDSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _touchIDSwitch;
}

- (void) valueChanged: (UISwitch *) touchIDSwitch {
    NSLog(@"on ==== %d",touchIDSwitch.on);
}

@end
