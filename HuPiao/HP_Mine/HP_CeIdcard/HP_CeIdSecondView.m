//
//  HP_CeIdSecondView.m
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CeIdSecondView.h"
#import "HP_CerIdcardTabCell.h"

@interface HP_CeIdSecondView () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UILabel * textLabel;
@property (nonatomic , strong) UIButton * commitBtn;
@property (nonatomic , strong) UITableView * tableView;

@end

@implementation HP_CeIdSecondView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        [self createSubviews];
        [self createConstraint];
    }
    return self;
}

#pragma mark - private
-(void)createSubviews {
    [self addSubview:self.textLabel];
    [self addSubview:self.tableView];
}

-(void)createConstraint {
    WS(wSelf);
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(15));
        make.left.mas_equalTo(HPFit(15));
        make.right.mas_equalTo(-HPFit(15));
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.textLabel.mas_bottom).offset (HPFit(15));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HP_CerIdcardTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"creIdCardCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    //    cell.model = self.listData[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;//self.listData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return section == 2 ? HPFit(15) : 0.0000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HPFit(15);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
        _textLabel.numberOfLines = 0;
        _textLabel.font = HPFontSize(14);
        _textLabel.textColor = HPSubTitleColor;
        _textLabel.text = @"请确保所有数据清晰可读，避免出现反光，不模糊。";
    }
    return _textLabel;
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[HP_CerIdcardTabCell class] forCellReuseIdentifier:@"creIdCardCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = HPFit(185);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
