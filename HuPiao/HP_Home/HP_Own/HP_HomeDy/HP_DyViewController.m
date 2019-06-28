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
#import "HP_DyModel.h"
#import "HZPhotoBrowser.h"

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
    self.pageLogStr = [self.isOwn isEqualToString:@"Own"] ? @"OwnDynamicPage" : @"DynamicPage";

    [self setupUI];
    
    [self configData];
}

- (void) setupUI {
    
    [self.view addSubview:self.tableView];

    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.mas_equalTo(0);
    }];
}

#pragma mark - 模拟数据
- (void)configData {
    self.loginUser = [MUser findFirstByCriteria:@"WHERE type = 1"];
    self.momentList = [[NSMutableArray alloc] init];
    [self.momentList addObjectsFromArray:[MomentUtil getMomentList:0 pageNum:10]];
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
        HP_DyModel * moment = [self.momentList objectAtIndex:indexPath.row];

        return moment.rowHeight;
    }
    HP_DyModel * moment = [self.momentList objectAtIndex:indexPath.row];
    return moment.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(wSelf);
    
    static NSString *CellIdentifier = @"dyCell";
    
    HP_DyCell * dyCell = [HP_DyCell dequeueReusableCellWithTableView:tableView Identifier:CellIdentifier];
    
    dyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    dyCell.index = indexPath;
    
    dyCell.user = self.user;
    
    dyCell.deleteBtn.hidden = [self.isOwn isEqualToString:@"Own"] ? NO : YES;
    
    dyCell.careBtn.hidden = [self.isOwn isEqualToString:@"Dy"] ? NO : YES;

    dyCell.dyModel = self.momentList[indexPath.row];

    dyCell.cellImgListBlock = ^(NSInteger index, HP_DyModel * _Nonnull dyModel) {
        NSLog(@"imgList = %@---%ld",dyModel.pictureList , index);
        [wSelf photoBrowserURLArray:dyModel.pictureList WithIndex:(int)index];
    };
    
    return dyCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HP_DyModel * dyModel = self.momentList[indexPath.row];
    
    HP_DyCommentController *baseVC = [HP_DyCommentController new];
    baseVC.title = @"动态详情";
    baseVC.dyModel = dyModel;
    [self.navigationController pushViewController:baseVC animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

#pragma mark - 相册预览
- (void) photoBrowserURLArray:(NSArray *)urlArr WithIndex:(int)index {
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.isFullWidthForLandScape = YES;
    browser.isNeedLandscape = YES;
    browser.currentImageIndex = index;
    if (urlArr.count > 0) {
        NSMutableArray * imgArr = @[].mutableCopy;
        for (MPicture * pictureUrl in urlArr) {
            if (!HPNULLString(pictureUrl.thumbnail)) {
                [imgArr addObject:pictureUrl.thumbnail];
            }
        }
        browser.imageArray = imgArr;
    }
    [browser show];
}

@end
