//
//  HP_HomeBaseViewController.m
//  HuPiao
//
//  Created by a on 2019/5/20.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_HomeBaseViewController.h"
#import "HP_HomeCell.h"
#import "HP_HomeDetailViewController.h"
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
    
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
    }
    return _tableView;
}

-(void)addTableView{
    __weak typeof (self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.messageList count];
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"homeCell";
    
    HP_HomeCell * homeCell = [HP_HomeCell dequeueReusableCellWithTableView:tableView Identifier:identifier];

    MUser * user = [self.messageList objectAtIndex:indexPath.row];
    
    homeCell.user = user;
    
    homeCell.index = indexPath;
    
    homeCell.address = self.address;
    
    homeCell.likeBtnActionBlock = ^(UIButton * _Nonnull button) {
         if (self.isLiked == YES) {
             [button setImage:[UIImage imageNamed:@"details_like_icon_press_20x20_"] forState:UIControlStateNormal];
             [button setTitle:@"103" forState:UIControlStateNormal];
             [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
             
             [self btnActionAnimationWithBtn:button];
             
             self.isLiked = NO;
         } else {
             [button setImage:[UIImage imageNamed:@"details_like_icon_20x20_"] forState:UIControlStateNormal];
             [button setTitle:@"102" forState:UIControlStateNormal];
             [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             
             self.isLiked = YES;
         }
    };
    
    return homeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MUser * user = [self.messageList objectAtIndex:indexPath.row];

    HP_HomeDetailNewViewController * detailVC = [HP_HomeDetailNewViewController suspendCenterPageVCWithUser:user IsOwn:NO];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.title = user.name;
    [self.navigationController pushViewController:detailVC animated:YES];
}
    
- (void) btnActionAnimationWithBtn:(UIButton *)sender {
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[sender layer] addAnimation:pulse forKey:nil];
}

- (NSMutableArray *)messageList {
    if (!_messageList) {
        _messageList = [[NSMutableArray alloc] init];
    }
    return _messageList;
}

@end
