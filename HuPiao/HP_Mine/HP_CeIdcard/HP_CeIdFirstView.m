//
//  HP_CeIdFirstView.m
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CeIdFirstView.h"
#import "HP_CeIdFirstCell.h"

@interface HP_CeIdFirstView () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) NSMutableArray * tfArray;
@property (nonatomic , strong) UILabel * textLabel;
@property (nonatomic , strong) UIButton * commitBtn;
@property (nonatomic , copy) NSString * realName;
@property (nonatomic , copy) NSString * phoneNum;
@property (nonatomic , copy) NSString * weChatNum;

@end

@implementation HP_CeIdFirstView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createSubviews];
        
        [self createConstraint];
    }
    return self;
}

#pragma mark - private
-(void)createSubviews {
    [self addSubview: self.textLabel];
    [self addSubview: self.tableView];
}

-(void)createConstraint {
    WS(wSelf);
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(15));
        make.left.mas_equalTo(HPFit(15));
        make.right.mas_equalTo(-HPFit(15));
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.textLabel.mas_bottom).offset (HPFit(30));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 2 ? HPFit(80) : HPFit(50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HPFit(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, HPFit(80))];
    
    self.commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(HPFit(15), view.frame.size.height - HPFit(40), self.frame.size.width - HPFit(30), HPFit(40))];
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitDown) forControlEvents:UIControlEventTouchDown];
    [self.commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.commitBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    [view addSubview:self.commitBtn];
    [self.commitBtn setBorderWithCornerRadius:8.0 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];

    return section == 2 ? view : nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"真实姓名",@"手机号",@"微信号", nil];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 40, 50)];
    titleLabel.text = arr[section];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = HPFontBoldSize(20);
    [view addSubview:titleLabel];
    
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"真实姓名",@"手机号",@"微信号", nil];
    return arr[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(wSelf);
    HP_CeIdFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CerIdcardTabCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    //    cell.model = self.listData[indexPath.section];
    
    cell.textFieldChangedBlock = ^(UITextField * _Nonnull textField, NSInteger tag, NSString * _Nonnull text) {
        NSLog(@"text = %@---%ld",text,(long)tag);
        
        wSelf.realName = tag == 0 && text.length > 0 ? text : @"";
        wSelf.phoneNum = tag == 1 && text.length > 0 ? text : @"";
        wSelf.weChatNum = tag == 2 && text.length > 0 ? text : @"";
    };
    
    return cell;
}

-(UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
        _textLabel.numberOfLines = 0;
        _textLabel.font = HPFontSize(14);
        _textLabel.textColor = HPSubTitleColor;
        _textLabel.text = @"请准确填写联系人、手机号、微信号，以便及时有效通过审核";
    }
    return _textLabel;
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[HP_CeIdFirstCell class] forCellReuseIdentifier:@"CerIdcardTabCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = HPFit(185);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void) commitAction {
    self.commitBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    if (self.firstCommitBlock) {
        NSLog(@"---------");
        self.firstCommitBlock();
    }
}

- (void) commitDown {
    self.commitBtn.backgroundColor = HPUIColorWithRGB(0x4D4D4D, 0.8);
}

- (NSMutableArray *)tfArray {
    if (!_tfArray) {
        _tfArray = @[].mutableCopy;
    }
    return _tfArray;
}

@end
