//
//  HP_OwnDetailViewController.m
//  HuPiao
//
//  Created by a on 2019/5/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_OwnDetailViewController.h"
#import "YNPageTableView.h"
#import "UIViewController+YNPageExtend.h"
#import "HP_InsertBGView.h"
#import "HP_CircleTableCell.h"
#import "HP_ImpressionTableCell.h"
#import "HP_PersonalTableCell.h"
#import "HP_EvaluateTableCell.h"

/// 开启刷新头部高度
#define kOpenRefreshHeaderViewHeight 0
/// cell高度
#define kCellHeight 44
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface HP_OwnDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
/// 占位cell高度
@property (nonatomic, assign) CGFloat placeHolderCellHeight;

@property (nonatomic, strong) UIButton * evaluate;

@end

@implementation HP_OwnDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    self.dataArray = @[].mutableCopy;
    /// 加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 3; i++) {
            [weakSelf.dataArray addObject:@""];
        }
        [self.tableView reloadData];
    });
//    [self addTableViewRefresh];
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
#pragma mark - 评价
- (void) evaluateAction:(UIButton *)sender {
    NSLog(@"立即评价");
}

/// 添加下拉刷新
- (void)addTableViewRefresh {
    __weak typeof (self) weakSelf = self;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < 3; i++) {
                [weakSelf.dataArray addObject:@""];
            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
}
/*
#pragma mark - 悬浮Center刷新高度方法
- (void)suspendTopReloadHeaderViewHeight {
    /// 布局高度
    CGFloat netWorkHeight = 400;
    __weak typeof (self) weakSelf = self;
    
    /// 结束刷新时 刷新 HeaderView高度
    [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
        YNPageViewController *VC = weakSelf.yn_pageViewController;
        if (VC.headerView.frame.size.height != netWorkHeight) {
            VC.headerView.frame = CGRectMake(0, 0, HPScreenW, netWorkHeight);
            //            CGFloat g = -VC.config.tempTopHeight;
            [VC reloadSuspendHeaderViewFrame];
            //            [self.tableView setContentOffset:CGPointMake(0, g - 100) animated:NO];
        }
    }];
}

#pragma mark - 求出占位cell高度
- (CGFloat)placeHolderCellHeight {
    CGFloat height = self.config.contentHeight - kCellHeight * self.dataArray.count;
    height = height < 0 ? 0 : height;
    return height;
}
*/
    
#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"与我亲密的",@"我的荣誉",@"主播形象",@"用户印象",@"个人资料",@"礼物柜",@"用户评价", nil];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    UILabel *  lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 5, 50 - 20)];
    lineLabel.backgroundColor = kSetUpCololor(R, G, B, 1.0);
    [view addSubview:lineLabel];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 40, 50)];
    titleLabel.text = arr[section];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = HPFontBoldSize(20);
    [view addSubview:titleLabel];
    
    self.evaluate = [[UIButton alloc] initWithFrame:CGRectMake(HPScreenW - 100, 5, 80, 40)];
    [self.evaluate setTitle:@"立即评价" forState:UIControlStateNormal];
    [self.evaluate setTitleColor:HPUIColorWithRGB(0x333333, 1.0) forState:UIControlStateNormal];
    [self.evaluate setTitleColor:HPUIColorWithRGB(0x000000, 0.5) forState:UIControlStateHighlighted];
    self.evaluate.titleLabel.font = HPFontSize(15);
    self.evaluate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.evaluate addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
    self.evaluate.hidden = section == 6 ? NO : YES;

    [view addSubview: self.evaluate];

    return view;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 6 ? 10 : 1;//self.dataArray.count;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        if (indexPath.section == 4) {
            return (HPScreenW - HPFit(70))/3 + HPFit(10);
        } else if (indexPath.section == 6) {
            return HPFit(60);
        } else
            return (HPScreenW - HPFit(90))/5 + HPFit(20);//kCellHeight;
    }
    return HPFit(60);//self.placeHolderCellHeight;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 3 ) {
        HP_ImpressionTableCell * imCell = [tableView dequeueReusableCellWithIdentifier:@"im"];
        imCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return imCell;
    } else if (indexPath.section == 4) {
        HP_PersonalTableCell * personalCell = [tableView dequeueReusableCellWithIdentifier:@"personal"];
        personalCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return personalCell;
    } else if (indexPath.section == 6) {
        HP_EvaluateTableCell * evaluateCell = [tableView dequeueReusableCellWithIdentifier:@"evaluate"];
        evaluateCell.accessoryType = UITableViewCellAccessoryNone;
        return evaluateCell;
    } else {
        HP_CircleTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BaseViewController *baseVC = [BaseViewController new];
//    baseVC.title = @"二级页面";
//    [self.navigationController pushViewController:baseVC animated:YES];
}
    
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.estimatedRowHeight = 0;
        [_tableView registerClass:[HP_CircleTableCell class] forCellReuseIdentifier:@"id"];
        [_tableView registerClass:[HP_ImpressionTableCell class] forCellReuseIdentifier:@"im"];
        [_tableView registerClass:[HP_PersonalTableCell class] forCellReuseIdentifier:@"personal"];
        [_tableView registerClass:[HP_EvaluateTableCell class] forCellReuseIdentifier:@"evaluate"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, HPFit(10), 0);
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
    
- (void)dealloc {
    NSLog(@"----- %@ delloc", self.class);
}


@end
