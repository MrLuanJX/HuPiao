//
//  HP_HomeBaseViewController.m
//  HuPiao
//
//  Created by a on 2019/5/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_HomeBaseViewController.h"
#import "HP_HomeCell.h"
#import "HP_HomeDetailNewViewController.h"
#import "MUser.h"
#import "HP_HomeHandler.h"
#import "HP_HomeModel.h"
#import "HP_AnchorOwnModel.h"
#import "ChatFaceHeleper.h"
#import "HP_ChatViewController.h"
#import "ZXChatBoxController.h"

@interface HP_HomeBaseViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong) ChatFaceGroup *curGroup;

@property (nonatomic , strong) UITableView * tableView;
    
@property (nonatomic , assign) BOOL isLiked;

@property (nonatomic , strong) NSMutableArray * messageList;

@property (nonatomic , copy) NSString * address;

@property (nonatomic , assign) NSInteger currentPage;

@property (nonatomic , strong) HP_AnchorOwnModel * ownModel;

@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度所用字典

@end

@implementation HP_HomeBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self.messageList removeAllObjects];
//    [self.messageList addObjectsFromArray:[MUser findAll]];
//    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"strUserId --- %@",[HP_UserTool sharedUserHelper].strUserId);
    
    self.pageLogStr = @"HomePage";
    
    self.currentPage = 1;
    
    self.isLiked = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self requestData];
    
    [self addTableView];

    [self addRefresh];
    // 注册极光用户
    [HP_MemberHandler registJGIMUser];
    // 登录极光用户
    [HP_MemberHandler loginJGIMUser];
    
//    [self.tableView.mj_header beginRefreshing];
    
    // 初始化emoji表情管理
    [self getFace];
}

-(void) addRefresh {
    __weak typeof (self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf.messageList removeAllObjects];
        [weakSelf requestData];
    }];
    
//    MJRefreshAutoNormalFooter 才可以显示出来 没有更多了
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark - 请求数据
- (void) requestData {
    WS(wSelf);
    
    [HP_HomeHandler executeHomeRequestWithIndex:self.currentIndex CurrentPage:self.currentPage MemberNO:[HP_UserTool sharedUserHelper].iMemberNo Success:^(id  _Nonnull obj) {
        
        [wSelf.tableView.mj_header endRefreshing];
        [wSelf.tableView.mj_footer endRefreshing];

        NSMutableArray * dataArray = [HP_HomeModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
        if (dataArray.count > 0) {
            [wSelf.messageList addObjectsFromArray:dataArray];
        } else {
            [wSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [wSelf.tableView reloadData];
        wSelf.currentPage += 1;
    } Fail:^(id  _Nonnull obj) {
        [wSelf.tableView.mj_header endRefreshing];
        [wSelf.tableView.mj_footer endRefreshing];
    }];
}

-(void)addTableView{
    __weak typeof (self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo (kStatusBarHeight);
        make.bottom.mas_equalTo(-k_bar_height);
        make.left.right.mas_equalTo(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.messageList count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

#pragma mark - UITableViewDelegate  UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return HPFit(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    
    return  view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return  [UIView new];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if(height) {
        return height.floatValue;
    } else {
        return HPFit(200);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HP_HomeCell * homeCell = [HP_HomeCell dequeueReusableCellWithTableView:tableView Identifier:@"homeCell"];
    if (self.messageList.count > 0) {
        homeCell.homeModel = self.messageList[indexPath.section];
    }
    
    return homeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HP_HomeModel * user = [self.messageList objectAtIndex:indexPath.section];

    [self requestOwnDataWithUser:user];
}

#pragma mark - 请求个人主页
- (void) requestOwnDataWithUser:(HP_HomeModel *)homeModel {
    WS(wSelf);
    
    [HP_OwnHandler executeAnchorOwnRequestWithIndexNO:homeModel.INDEX_NO Success:^(id  _Nonnull obj) {
        wSelf.ownModel = [HP_AnchorOwnModel mj_objectWithKeyValues:obj[@"data"]];
        // 3.GCD
        dispatch_async(dispatch_get_main_queue(), ^{
            HP_HomeDetailNewViewController * detailVC = [HP_HomeDetailNewViewController suspendCenterPageVCWithUser:homeModel IsOwn:@"Home" WithOwnModel:wSelf.ownModel];
            detailVC.title = HPNULLString(homeModel.nickname) ? homeModel.NICKNAME : homeModel.nickname;
            detailVC.user = homeModel;
            detailVC.ownModel = wSelf.ownModel;
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        });
    } Fail:^(id  _Nonnull obj) {
        
    }];
}

- (NSMutableArray *)messageList {
    if (!_messageList) {
        _messageList = [[NSMutableArray alloc] init];
    }
    return _messageList;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HP_HomeCell class] forCellReuseIdentifier:@"homeCell"];
        _tableView.estimatedRowHeight = HPFit(200);
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (HP_AnchorOwnModel *)ownModel {
    if (!_ownModel) {
        _ownModel = [HP_AnchorOwnModel new];
    }
    return _ownModel;
}

- (void) getFace {
    _curGroup = [[[ChatFaceHeleper sharedFaceHelper] faceGroupArray] objectAtIndex:0];
    if (_curGroup.facesArray == nil) {
        /**
         *   这个groupID 就是该组特有的 ID 例如，系统表情就是 0 自己添加的一组就是 1 等等
         */
        _curGroup.facesArray = [[ChatFaceHeleper sharedFaceHelper] getFaceArrayByGroupID:_curGroup.groupID];
    }
}

@end
