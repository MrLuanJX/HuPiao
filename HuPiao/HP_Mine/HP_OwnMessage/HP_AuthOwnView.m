//
//  HP_AuthOwnView.m
//  HuPiao
//
//  Created by a on 2019/6/5.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_AuthOwnView.h"
#import "HP_AuthMessageHeadView.h"

@interface HP_AuthOwnView () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) HP_AuthMessageHeadView * collView;

@property (nonatomic , strong) NSMutableArray * titleArr;

@end

@implementation HP_AuthOwnView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addTableView];
    }
    return self;
}

- (void) addTableView {
    WS(wSelf);
    
    [self addSubview: self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.tableView.tableHeaderView = self.collView;
    
    self.collView.collectSeleteBlock = ^(NSIndexPath * _Nonnull index, HP_AuthCollectCell * _Nonnull cell) {
        if (wSelf.collectSeleteBlock) {
            wSelf.collectSeleteBlock(index, cell);
        }
    };
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.font = HPFontSize(14);
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.detailTextLabel.text = indexPath.row == 0 ? self.user.name : @"";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HPFit(60);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath: indexPath];
    
    if (self.cellSeleteBlock) {
        self.cellSeleteBlock(indexPath, cell);
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
//        _tableView.estimatedRowHeight = 0;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    }
    return _tableView;
}

- (HP_AuthMessageHeadView *)collView {
    if (!_collView ) {
        _collView = [[HP_AuthMessageHeadView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, (HPScreenW - HPFit(30))/3 * 1.5 * 3 + HPFit(30))]; 
    }
    return _collView;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"昵称",@"出生日期",@"身高",@"体重",@"兴趣",@"职业",@"个性签名", nil];
    }
    return _titleArr;
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
    self.collView.dataSource = dataSource;
}

@end
