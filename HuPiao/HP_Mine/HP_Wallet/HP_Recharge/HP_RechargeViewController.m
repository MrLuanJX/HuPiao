//
//  HP_RechargeViewController.m
//  HuPiao
//
//  Created by a on 2019/6/18.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_RechargeViewController.h"
#import "HP_WalletHeadView.h"

@interface HP_RechargeCell ()

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) UIImageView * icon;

@property (nonatomic , strong) UILabel * title;

@property (nonatomic , strong) UIImageView * chooseSign;

@property (nonatomic , copy) NSString * dataModel;

@end

@implementation HP_RechargeCell

- (void)setDataModel:(NSString *)dataModel {
    _dataModel = dataModel;
    
    NSArray *array = [dataModel componentsSeparatedByString:@","];
    
    self.title.attributedText = [HP_Label setUpFirstStr:array.firstObject FirstColor:HPUIColorWithRGB(0x666666, 1.0) FirstFont:HPFontBoldSize(14) SecondStr:array.lastObject SecondColor:HPUIColorWithRGB(0xCD3700, 1.0) SecondFont:HPFontSize(14)];
}

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_RechargeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[HP_RechargeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    WS(wSelf);
    
    [self.contentView addSubview: self.icon];
    [self.contentView addSubview: self.title];
    [self.contentView addSubview: self.chooseSign];

    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo (HPFit(15));
        make.height.mas_equalTo (HPFit(20));
        make.right.mas_equalTo (-HPFit(15));
        
        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom).offset (-HPFit(15));
    }];
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
    }
    return _title;
}

@end

@interface HP_RechargeViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) UIButton * commitBtn;

@property (nonatomic , strong) NSMutableArray * dataSource;

@property (nonatomic , strong) HP_WalletHeadView * headView;

@end

@implementation HP_RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageLogStr = @"RechargePage";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableView];
    
    [self setupRightNav];
}

- (void) setupRightNav {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(helpAction) Title:@"帮助" TitleColor:HPUIColorWithRGB(0x333333, 1.0)];
}

- (void) helpAction {
    NSLog(@"帮助");
}

- (void) addTableView {
    WS(wSelf);
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);
    }];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    view.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, HPScreenW - 20, 20)];
    titleLabel.font = HPFontSize(14);
    titleLabel.textColor = HPUIColorWithRGB(0x666666, 1.0);
    titleLabel.text = @"选择购买项目";
    
    [view addSubview:titleLabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return HPFit(80);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HPFit(80))];
    self.commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(HPFit(15), view.frame.size.height - HPFit(40), view.size.width - HPFit(30), HPFit(40))];
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitBtn setTitle:@"立 即 充 值" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitDown) forControlEvents:UIControlEventTouchDown];
    [self.commitBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.commitBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    [view addSubview:self.commitBtn];
    [self.commitBtn setBorderWithCornerRadius:8.0 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
    return  view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_RechargeCell * cell = [HP_RechargeCell dequeueReusableCellWithTableView:tableView Identifier:@"rechargeCell"];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"6元买,60H币",@"30元买,210H币",@"60元买,470H币",@"98元买,680H币",@"218元买,1888H币",nil];
    
    cell.dataModel = arr[indexPath.row];
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.indexPathsForSelectedRows.count > 1) {
        [tableView deselectRowAtIndexPath:tableView.indexPathsForSelectedRows[0] animated:NO];
    }
}

- (void) commitAction: (UIButton *) sender{
    self.commitBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    NSArray * arr = self.tableView.indexPathsForSelectedRows;
    
    for (NSIndexPath * index in arr) {
        NSLog(@"--%ld---%ld",index.section , index.row);
    }
}

- (void) commitDown {
    self.commitBtn.backgroundColor = HPUIColorWithRGB(0x4D4D4D, 0.8);
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;//可以省略不设置
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[HP_RechargeCell class] forCellReuseIdentifier:@"rechargeCell"];
        _tableView.editing = YES;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (HP_WalletHeadView *)headView {
    if (!_headView) {
        _headView = [[HP_WalletHeadView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, HPFit(200))];
    }
    return _headView;
}

@end
