//
//  HP_SeleteViewController.m
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_SeleteViewController.h"

@interface HP_SeleteCell()

@property (nonatomic , strong) UIImageView * seleteImg;

@property (nonatomic , strong) UILabel * title;

@end

@implementation HP_SeleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        [self createConstrainte];
    }
    return self;
}

- (void) createUI {
    [self.contentView addSubview: self.seleteImg];
    [self.contentView addSubview: self.title];
}

- (void) createConstrainte {
    WS(wSelf);
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo (0);
    }];
    
    [self.seleteImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (wSelf.mas_centerY);
        make.left.mas_equalTo (HPFit(15));
        make.width.height.mas_equalTo (HPFit(18));
    }];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (wSelf.seleteImg.mas_centerY);
        make.left.mas_equalTo (wSelf.seleteImg.mas_right).offset (HPFit(10));
        make.right.mas_equalTo (-HPFit(15));
    }];
}

- (UIImageView *)seleteImg {
    if (!_seleteImg) {
        _seleteImg = [UIImageView new];
        _seleteImg.image = [UIImage imageNamed:@"normalmageSource"];
    }
    return _seleteImg;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.font = HPFontSize(15);
        _title.textColor = HPUIColorWithRGB(0x333333, 1.0);
    }
    return _title;
}

@end

@interface HP_SeleteViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , assign) NSIndexPath * selectTag;

@property (strong, nonatomic) NSMutableArray * selectIndexs; //多选选中的行

@end

@implementation HP_SeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableView];
    
    [self setupNavRightItem];
}

- (void) setupNavRightItem {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(sureAction:) Title:@"保存" TitleColor:HPUIColorWithRGB(0xFF0000, 1.0)];
}

- (void) sureAction : (UIBarButtonItem *) sender{
    NSLog(@"保存----%@",self.dataArray[self.selectTag.row]);
    
    if (self.jobSeleteBlock) {
        self.jobSeleteBlock(self.selectTag, self.dataArray);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addTableView {
    WS(wSelf);
    [self.view addSubview: self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(wSelf.view);
    }];    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count > 0 ? self.dataArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_SeleteCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HP_SeleteCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"seleteCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (self.dataArray.count > 0) {
        NSDictionary * dict = self.dataArray[indexPath.row];
        cell.title.text = dict[@"title"];
    }
    if ([self.dataArray[indexPath.row][@"seleted"] isEqualToString:@"0"]) {
        cell.seleteImg.image = [UIImage imageNamed:@"normalmageSource"];
    } else {
        cell.seleteImg.image = [UIImage imageNamed:@"insEyeImageSource"];
        self.selectTag = indexPath;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary * dictMut  = [NSMutableDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
    
    NSMutableDictionary * seletedictMut  = [NSMutableDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:self.selectTag.row]];
    
    HP_SeleteCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (self.selectTag) {
        HP_SeleteCell *selectedCell = [tableView cellForRowAtIndexPath:self.selectTag];
        selectedCell.accessoryType = UITableViewCellAccessoryNone;
        selectedCell.seleteImg.image = [UIImage imageNamed:@"normalmageSource"];
        seletedictMut[@"seleted"] = @"0";
        [self.dataArray replaceObjectAtIndex:self.selectTag.row withObject:seletedictMut];
    }
    self.selectTag = indexPath;
    cell.seleteImg.image = [UIImage imageNamed:@"insEyeImageSource"];
    dictMut[@"seleted"] = @"1";
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:dictMut];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
        _tableView.estimatedRowHeight = 0;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HP_SeleteCell class] forCellReuseIdentifier:@"seleteCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (NSMutableArray *)selectIndexs {
    if (!_selectIndexs) {
        _selectIndexs = @[].mutableCopy;
    }
    return _selectIndexs;
}

@end
