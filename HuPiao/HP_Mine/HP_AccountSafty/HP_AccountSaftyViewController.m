//
//  HP_AccountSaftyViewController.m
//  HuPiao
//
//  Created by a on 2019/6/21.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_AccountSaftyViewController.h"
#import "HP_TouchIDCell.h"
#import "HP_UpdatePwdViewController.h"

@interface HP_AccountSaftyViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * dataArray;

@end

@implementation HP_AccountSaftyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);

    [self addTableView];
}

- (void) addTableView {
    WS(wSelf);
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(wSelf.view);
    }];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10 ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * arr = self.dataArray[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HPFit(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        HP_TouchIDCell * touchIDCell = [HP_TouchIDCell dequeueReusableCellWithTableView:tableView Identifier:@"touchIDCell"];
        
        touchIDCell.title.text = self.dataArray[indexPath.section][indexPath.row];
        
        return touchIDCell;
    } else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"accountCell"];
        }
        cell.accessoryType = indexPath.row == 0 ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        cell.detailTextLabel.font = HPFontSize(14);
        
        cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    HP_UpdatePwdViewController * updatePwdVC = [HP_UpdatePwdViewController new];

    if (indexPath.section == 0 && indexPath.row == 1) {
        [self.navigationController pushViewController:updatePwdVC animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"accountCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        NSString * lockStr = k_iphone_x ? @"面容解锁" : @"指纹解锁";
        _dataArray = [NSMutableArray arrayWithObjects:@[@"修改密码",lockStr],@[@"关于我们",@"当前版本"], nil];
    }
    return _dataArray;
}

@end
