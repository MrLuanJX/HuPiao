//
//  HP_CashWithdrawalViewController.m
//  HuPiao
//
//  Created by a on 2019/6/12.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CashWithdrawalViewController.h"

@interface HP_CashWithdrawalCell () <UITextFieldDelegate>

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) UITextField * textField;

@property (nonatomic , strong) NSIndexPath * index;

@end

@implementation HP_CashWithdrawalCell

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
    switch (index.section) {
        case 0:
            self.textField.placeholder = @"请输入提现金额";
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case 1:
            self.textField.placeholder = @"请输入银行卡号";
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case 2:
            self.textField.placeholder = @"请输入开户行";
            self.textField.keyboardType = UIKeyboardTypeDefault;
            break;
        case 3:
            self.textField.placeholder = @"请输入手机号";
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case 4:
            self.textField.placeholder = @"请输入微信号";
            self.textField.keyboardType = UIKeyboardTypeDefault;
            break;
        default:
            break;
    }
}

// model对象赋值
- (void)setModel:(HP_CashWithdrawalModel *)model{
    _model = model;
    self.textField.text = model.text;
}

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_CashWithdrawalCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[HP_CashWithdrawalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
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
    [self.contentView addSubview: self.textField];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo (0);
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo (0);
        make.left.mas_equalTo (HPFit(15));
        make.right.mas_equalTo (-HPFit(15));
    }];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.font = HPFontSize(14);
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

// 代理方法
-(void)changedTextField:(UITextField *)textField {

    if ([self.delegate respondsToSelector:@selector(textFieldCellText:index:)]) {
        //这里讲textField中输入的内容和model中存储的index传递到controller
        [self.delegate textFieldCellText:textField.text index:_model.index];
    }
}

@end

@interface HP_CashWithdrawalViewController () <UITableViewDelegate , UITableViewDataSource , HP_CashWithdrawalCellDelegate>

@property (nonatomic , strong) UILabel * textLabel;

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) UIButton * commitBtn;

@property (nonatomic , strong) NSMutableDictionary * dict;

@property (nonatomic , strong) NSMutableArray * dataSource;

@property (nonatomic , assign) BOOL isEmpty;

@end

@implementation HP_CashWithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableView];
}

- (void) addTableView {
    WS(wSelf);
    [self.view addSubview: self.textLabel];
    [self.view addSubview: self.tableView];
    
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HPFit(15) + k_top_height);
        make.left.mas_equalTo(HPFit(15));
        make.right.mas_equalTo(-HPFit(15));
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.textLabel.mas_bottom).offset (HPFit(20));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);
    }];
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"提现金额",@"开户行",@"银行卡号",@"手机号",@"微信号", nil];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 40, 40)];
    titleLabel.attributedText = [self setUpmoney:@"●  " danwei:arr[section]];

    [view addSubview:titleLabel];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 4 ? HPFit(80) : 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HPFit(80))];
    self.commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(HPFit(15), view.frame.size.height - HPFit(40), view.size.width - HPFit(30), HPFit(40))];
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitBtn setTitle:@"立 即 申 请" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitDown) forControlEvents:UIControlEventTouchDown];
    [self.commitBtn addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.commitBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    self.commitBtn.tag = section;
    [view addSubview:self.commitBtn];
    [self.commitBtn setBorderWithCornerRadius:8.0 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
    return section == 4 ? view : [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"提现金额",@"开户行",@"银行卡号",@"手机号",@"微信号", nil];
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HPFit(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    HP_CashWithdrawalCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HP_CashWithdrawalCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cashCell"];
    }
 
    cell.model = self.dataSource[indexPath.section];
    cell.delegate = self;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.index = indexPath;
    
    return cell;
}

//代理回调，比对indexPath将对应的text进行修改保存
- (void)textFieldCellText:(NSString *)text index:(NSIndexPath *)index{
    for (int i = 0; i < self.dataSource.count; i++) {
        HP_CashWithdrawalModel *model = self.dataSource[i];
        if (index == model.index) {
            model.text = text;
        }
    }
}

- (void) commitAction: (UIButton *) sender{
    self.commitBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    for (int i = 0; i < 5; i++) {
        HP_CashWithdrawalModel *model = self.dataSource[i];
        if (model.index.section == 0) {
            NSLog(@"0");
            NSLog(@"text = %@",model.text);
            if (model.text.length == 0) {
                NSLog(@"金额不空");
                self.isEmpty = YES;
                return;
            }else {
                self.isEmpty = NO;
            }
        } else if (model.index.section == 1) {
            NSLog(@"1");
            NSLog(@"text = %@",model.text);
            if (model.text.length == 0) {
                NSLog(@"开户行不空");
                self.isEmpty = YES;
                return;
            } else {
                self.isEmpty = NO;
            }
        } else if (model.index.section == 2) {
            NSLog(@"2");
            NSLog(@"text = %@",model.text);
            if (model.text.length == 0) {
                NSLog(@"卡号不空");
                self.isEmpty = YES;
                return;
            } else {
                self.isEmpty = NO;
            }
        } else if (model.index.section == 3) {
            NSLog(@"2");
            NSLog(@"text = %@",model.text);
            if (model.text.length == 0) {
                NSLog(@"手机号不空");
                self.isEmpty = YES;
                return;
            } else {
                self.isEmpty = NO;
            }
        } else if (model.index.section == 4) {
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
        NSLog(@"立即申请");
    }
}

- (void) commitDown {
    self.commitBtn.backgroundColor = HPUIColorWithRGB(0x4D4D4D, 0.8);
}

-(UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
        _textLabel.numberOfLines = 0;
        _textLabel.font = HPFontSize(14);
        _textLabel.textColor = HPSubTitleColor;
        _textLabel.text = @"为确保资金安全，请如实填写提现申请信息"; // \n\n10H币 = 1元
    }
    return _textLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HP_CashWithdrawalCell class] forCellReuseIdentifier:@"cashCell"];
    }
    return _tableView;
}

- (NSMutableAttributedString*)setUpmoney:(NSString *)money danwei:(NSString *)danwei{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",money,danwei]];
    
    [str addAttribute:NSForegroundColorAttributeName
                value: kSetUpCololor(185, 185, 185, 1.0)
                range:NSMakeRange(0,[money length])];
    [str addAttribute:NSForegroundColorAttributeName
                value: HPUIColorWithRGB(0x3333333, 1.0)
                range:NSMakeRange([money length],[danwei length])];
    
    [str addAttribute:NSFontAttributeName
                value: HPFontSize(10)
                range:NSMakeRange(0, [money length])];
    [str addAttribute:NSFontAttributeName
                value: HPFontBoldSize(17)
                range:NSMakeRange([money length], [danwei length])];
    
    return str;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
        //循环创建model，s初始设置text为空，并编号index
        for (int i = 0; i < 5; i++) {
            HP_CashWithdrawalModel *model = [[HP_CashWithdrawalModel alloc] init];
            model.text = @"";
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:i];
            model.index = index;
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}



@end
