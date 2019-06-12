//
//  HP_CeIdFirstCell.m
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CeIdFirstCell.h"

@interface HP_CeIdFirstCell() <UITextFieldDelegate>

@property (nonatomic , strong) UITextField * textField;

@end

@implementation HP_CeIdFirstCell

// model对象赋值
- (void)setModel:(HP_CashWithdrawalModel *)model{
    _model = model;
    self.textField.text = model.text;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    self.textField.keyboardType = indexPath.section == 1 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
}

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_CeIdFirstCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_CeIdFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
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
    [self.contentView addSubview: self.textField];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo (0);
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);
        make.left.mas_equalTo (HPFit(15));
        make.right.mas_equalTo (-HPFit(15));
        make.height.mas_equalTo (HPFit(30));
        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom);
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.textField borderForColor:HPUIColorWithRGB(0x999999, 1.0) borderWidth:1 borderType:UIBorderSideTypeBottom];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = HPFontSize(14);
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

// 代理方法
-(void)changedTextField:(UITextField *)textField {
//- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([self.delegate respondsToSelector:@selector(textFieldCellText:index:)]) {
        //这里讲textField中输入的内容和model中存储的index传递到controller
        [self.delegate textFieldCellText:textField.text index:_model.index];
    }
}


@end
