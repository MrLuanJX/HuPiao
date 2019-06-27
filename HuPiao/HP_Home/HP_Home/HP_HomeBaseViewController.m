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

@interface HP_HomeBaseViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;
    
@property (nonatomic , assign) BOOL isLiked;

@property (nonatomic , strong) NSMutableArray * messageList;

@property (nonatomic , copy) NSString * address;
@end

@implementation HP_HomeBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.messageList removeAllObjects];
    [self.messageList addObjectsFromArray:[MUser findAll]];
    [self.tableView reloadData];
}

- (void) getlocation {
    WS(wSelf);
    [[CLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        NSLog(@"latitude = %f --- %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude);
        
    } withAddress:^(NSString *addressString) {
        NSLog(@"addressString = %@",addressString);
        wSelf.address = addressString;
    } FirstTime:^{
        NSLog(@"first");
        [self.messageList removeAllObjects];
        [self.messageList addObjectsFromArray:[MUser findAll]];
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLiked = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableView];
    
    [self getlocation];
}

-(void)addTableView{
    __weak typeof (self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"homeCell";
    
    HP_HomeCell * homeCell = [HP_HomeCell dequeueReusableCellWithTableView:tableView Identifier:identifier];

    MUser * user = [self.messageList objectAtIndex:indexPath.section];
    
    homeCell.user = user;
    
    homeCell.index = indexPath;
    
    homeCell.address = self.address;
    
    return homeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MUser * user = [self.messageList objectAtIndex:indexPath.section];

    HP_HomeDetailNewViewController * detailVC = [HP_HomeDetailNewViewController suspendCenterPageVCWithUser:user IsOwn:@"Home"];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.title = user.name;
    [self.navigationController pushViewController:detailVC animated:YES];
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
        _tableView.estimatedRowHeight = 50;
    }
    return _tableView;
}

@end
