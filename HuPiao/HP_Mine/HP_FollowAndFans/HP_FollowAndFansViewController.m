//
//  HP_FollowAndFansViewController.m
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_FollowAndFansViewController.h"

@interface HP_FollowAndFansViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation HP_FollowAndFansViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[MUser findAll]];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addViews];
}

- (void) addViews{
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo (0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_FollowAndFansCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HP_FollowAndFansCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    cell.user = self.dataArray[indexPath.row];
    
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HP_FollowAndFansCell class] forCellReuseIdentifier:@"id"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
#pragma mark - cell
@interface HP_FollowAndFansCell ()

@property (nonatomic, strong) HP_ImageView * avatarImageV;
@property (nonatomic, strong) UILabel * nameLabel;

@end

@implementation HP_FollowAndFansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    WS(wSelf);
    
    // 头像
    [self.contentView addSubview:self.avatarImageV];
    // 昵称
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo (0);
    }];
    
    [self.avatarImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (HPFit(15));
        make.top.mas_equalTo (HPFit(10));
        make.width.height.mas_equalTo (HPFit(50));
        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom).offset(-HPFit(10));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (wSelf.avatarImageV.mas_centerY);
        make.left.mas_equalTo (wSelf.avatarImageV.mas_right).offset(HPFit(10));
        make.right.mas_equalTo (-HPFit(15));
    }];
}

- (void)setUser:(MUser *)user {
    _user = user;
    [self.avatarImageV sd_setImageWithURL:[NSURL URLWithString:user.portrait] placeholderImage:nil];
    self.nameLabel.text = user.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.avatarImageV setBorderWithCornerRadius:5.0 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (HP_ImageView *)avatarImageV {
    if (!_avatarImageV) {
        _avatarImageV = [HP_ImageView new];
    }
    return _avatarImageV;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = HPFontSize(17);
        _nameLabel.textColor = HPUIColorWithRGB(0x333333, 1.0);
    }
    return _nameLabel;
}
@end
