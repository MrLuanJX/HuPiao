//
//  HP_IntimateViewController.m
//  HuPiao
//
//  Created by a on 2019/6/21.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_IntimateViewController.h"
#import "HP_IntimateCell.h"

@interface HP_IntimateViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@end

@implementation HP_IntimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"亲密度";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableView];
}

- (void) addTableView {
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  HPFit(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(wSelf);
    
    static NSString *CellIdentifier = @"intimateCell";
    
    HP_IntimateCell * intimateCell = [HP_IntimateCell dequeueReusableCellWithTableView:tableView Identifier:CellIdentifier];
    
    intimateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    intimateCell.index = indexPath;
    
    return intimateCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
