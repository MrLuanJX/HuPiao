//
//  HP_DyViewController.m
//  HuPiao
//
//  Created by a on 2019/5/31.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_DyViewController.h"
#import "HP_DyCell.h"
#import "HP_DyCommentController.h"
#import "MomentUtil.h"

/// cell高度
#define kCellHeight 44

@interface HP_DyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
/// 占位cell高度
@property (nonatomic, assign) CGFloat placeHolderCellHeight;

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) int value;

@property (nonatomic , strong) MUser * loginUser; // 当前用户
@property (nonatomic, strong) NSMutableArray * momentList;  // 朋友圈动态列表

@end

@implementation HP_DyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self configData];
}

- (void) setupUI {
    __weak typeof (self) weakSelf = self;

    [self.view addSubview:self.tableView];


    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.mas_equalTo(0);
    }];
    
//    self.dataArray = @[].mutableCopy;
    /// 加载数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (int i = 0; i < 10; i++) {
//            [weakSelf.dataArray addObject:@""];
//        }
//        [self.tableView reloadData];
//    });
//    [self addTableViewRefresh];
}

#pragma mark - 模拟数据
- (void)configData {
    self.loginUser = [MUser findFirstByCriteria:@"WHERE type = 1"];
    self.momentList = [[NSMutableArray alloc] init];
    [self.momentList addObjectsFromArray:[MomentUtil getMomentList:0 pageNum:10]];
//    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.momentList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        // 使用缓存行高，避免计算多次
        Moment * moment = [self.momentList objectAtIndex:indexPath.row];
        NSLog(@"rowHeight1 = %lf",moment.rowHeight);

        return moment.rowHeight;
//        return indexPath.row %2 == 0 ? HPFit(735) : HPFit(750);
        //kCellHeight;   HPFit(720);
    }
    Moment * moment = [self.momentList objectAtIndex:indexPath.row];
    return moment.rowHeight;
//    return self.placeHolderCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"dyCell";
    
    HP_DyCell * dyCell = [HP_DyCell dequeueReusableCellWithTableView:tableView Identifier:CellIdentifier];

    dyCell.index = indexPath;
    
    dyCell.user = self.user;
    
    dyCell.deleteBtn.hidden = [self.isOwn isEqualToString:@"Own"] ? NO : YES;
    
    dyCell.careBtn.hidden = [self.isOwn isEqualToString:@"Dy"] ? NO : YES;

    dyCell.dyModel = self.momentList[indexPath.row];

    return dyCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    HP_DyCommentController *baseVC = [HP_DyCommentController new];
    baseVC.title = @"动态详情";
    baseVC.user = self.user;
    [self.navigationController pushViewController:baseVC animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        // CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.height)
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"----- %@ delloc", self.class);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
    //     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.tableView.mj_header beginRefreshing];
    //    });
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

@end
