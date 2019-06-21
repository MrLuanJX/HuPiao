//
//  HP_CeIdFirstView.m
//  HuPiao
//
//  Created by a on 2019/6/11.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CeIdFirstView.h"
#import "HP_CeIdFirstCell.h"
#import "HP_CashWithdrawalModel.h"

@interface HP_CeIdFirstView () <UITableViewDelegate , UITableViewDataSource ,HP_CeIdFirstCellDelegate>

@property (nonatomic , strong) UILabel * textLabel;
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIButton * commitBtn;
@property (nonatomic , strong) NSMutableArray * dataSource;
@property (nonatomic , strong) NSMutableArray * textArr;
@property (nonatomic , assign) BOOL isEmpty;

@end

@implementation HP_CeIdFirstView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.isEmpty = YES;
        
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
        make.top.mas_equalTo (wSelf.textLabel.mas_bottom).offset (HPFit(20));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 2 ? HPFit(80) : HPFit(50);
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HPFit(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"真实姓名",@"手机号",@"微信号", nil];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, HPFit(40))];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(HPFit(10), HPFit(10), self.frame.size.width - HPFit(40), HPFit(20))];
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
    HP_CeIdFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CerIdcardTabCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.model = self.dataSource[indexPath.section];
    cell.delegate = self;
    
    return cell;
}

//代理回调，比对indexPath将对应的text进行修改保存
- (void) textFieldCellText:(NSString *)text index:(NSIndexPath *)index {
    for (int i = 0; i < self.dataSource.count; i++) {
        HP_CashWithdrawalModel *model = self.dataSource[i];
        if (index == model.index) {
            model.text = text;
        }
    }
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
    NSLog(@"commit");
    self.commitBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    
    for (int i = 0; i < 3; i++) {
        HP_CashWithdrawalModel *model = self.dataSource[i];
        if (model.index.section == 0) {
            NSLog(@"0");
            NSLog(@"text = %@",model.text);
            if (model.text.length == 0) {
                NSLog(@"名不空");
                self.isEmpty = YES;
                return;
            }else {
                self.isEmpty = NO;
            }
        } else if (model.index.section == 1) {
            NSLog(@"1");
            NSLog(@"text = %@",model.text);
            if (model.text.length == 0) {
                NSLog(@"手机不空");
                self.isEmpty = YES;

                return;
            } else {
                self.isEmpty = NO;
            }
        } else if (model.index.section == 2) {
            NSLog(@"2");
            NSLog(@"text = %@",model.text);
            if (model.text.length == 0) {
                NSLog(@"微信不空");
                self.isEmpty = YES;

                return;
            } else {
                self.isEmpty = NO;
            }
        }
    }
    if (self.isEmpty == NO) {
        if (self.firstCommitBlock) {
            self.firstCommitBlock();
        }
    }
}

- (void) commitDown {
    self.commitBtn.backgroundColor = HPUIColorWithRGB(0x4D4D4D, 0.8);
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
        //循环创建model，s初始设置text为空，并编号index
        for (int i = 0; i < 3; i++) {
            HP_CashWithdrawalModel *model = [[HP_CashWithdrawalModel alloc] init];
            model.text = @"";
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:i];
            model.index = index;
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (NSMutableArray *)textArr {
    if (!_textArr) {
        _textArr = @[].mutableCopy;
    }
    return _textArr;
}

@end
