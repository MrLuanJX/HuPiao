//
//  HP_MessageListViewController.m
//  HuPiao
//
//  Created by a on 2019/6/3.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_MessageListViewController.h"
#import "HP_TableView.h"
#import "HP_ImageListView.h"
#import "SearchResultViewController.h"
#import "HP_Utility.h"
#import "HP_ChatViewController.h"

@interface HP_MessageListViewController () <UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, strong) HP_TableView * tableView;
@property (nonatomic, strong) NSMutableArray * messageList;
@property (nonatomic, strong) NSMutableArray * userList;

@end

@implementation HP_MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 极光统计界面log
    self.pageLogStr = @"MessagePage";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.userList removeAllObjects];
    [self.messageList removeAllObjects];
    [self.messageList addObjectsFromArray:[HP_Message findAll]];
    [self.userList addObjectsFromArray:[MUser findAll]];
    [self.tableView reloadData];
}

#pragma mark - lazy load
- (HP_TableView *)tableView {
    if (!_tableView) { //  - k_bar_height
        _tableView = [[HP_TableView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, HPScreenH-k_top_height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        SearchResultViewController * controller = [[SearchResultViewController alloc] init];
        UISearchController * searchController = [[UISearchController alloc] initWithSearchResultsController:controller];
        searchController.searchBar.userInteractionEnabled = NO;
        searchController.searchBar.enablesReturnKeyAutomatically = YES;
        searchController.searchBar.searchTextPositionAdjustment = UIOffsetMake(5, 0);
        [searchController.searchBar setPositionAdjustment:UIOffsetMake((HPScreenW-60)/2.0, 0) forSearchBarIcon:UISearchBarIconSearch];
        [searchController.searchBar setBackgroundImage:[HP_Utility imageWithRenderColor:k_background_color renderSize:CGSizeMake(1, 1)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [searchController.searchBar sizeToFit];
        // 输入框
        UITextField * searchField = [searchController.searchBar valueForKey:@"_searchField"];
        searchField.borderStyle = UITextBorderStyleNone;
        searchField.textAlignment = NSTextAlignmentCenter;
        searchField.textColor = [UIColor grayColor];
        searchField.font = [UIFont systemFontOfSize:16];
        searchField.placeholder = @"搜索";
        searchField.layer.masksToBounds = YES;
        searchField.layer.cornerRadius = 5;
        searchField.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = searchController.searchBar;
    }
    return _tableView;
}

- (NSMutableArray *)messageList {
    
    if (!_messageList) {
        _messageList = [[NSMutableArray alloc] init];
    }
    return _messageList;
}

- (NSMutableArray *)userList {
    if (!_userList) {
        _userList = @[].mutableCopy;
    }
    return _userList;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"MessageCell";
    HP_MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HP_MessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    HP_Message * message = [self.messageList objectAtIndex:indexPath.row];
    cell.message = message;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    HP_Message * message = [self.messageList objectAtIndex:indexPath.row];
//    MUser * user = [self.userList objectAtIndex:indexPath.row];
//
//    HP_ChatViewController * chatVC = [HP_ChatViewController new];
//    chatVC.navTitle = message.userName;
//    chatVC.user = user;
//    [self.navigationController pushViewController:chatVC animated:YES];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


#pragma mark - ------------------ 对话cell ------------------
@interface HP_MessageCell ()

@property (nonatomic, strong) HP_ImageView * avatarImageV;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * messageLabel;
@property (nonatomic, strong) UILabel * timeLabel;

@end

@implementation HP_MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 头像
        _avatarImageV = [[HP_ImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
        _avatarImageV.layer.cornerRadius = 4.0;
        _avatarImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarImageV];
        // 昵称
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 13, HPScreenW - 150, 25)];
        _nameLabel.font = [UIFont systemFontOfSize:17.0];
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.nameLabel];
        // 消息
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 37, HPScreenW-100, 20)];
        _messageLabel.font = [UIFont systemFontOfSize:14.0];
        _messageLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_messageLabel];
        // 时间
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(HPScreenW-110, 10, 100, 25)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

#pragma mark - setter
- (void)setMessage:(HP_Message *)message {
    
    [self.avatarImageV sd_setImageWithURL:[NSURL URLWithString:message.userPortrait] placeholderImage:nil];
    self.nameLabel.text = message.userName;
    self.messageLabel.text = message.content;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[HP_Utility getMessageTime:message.time]];
}


@end
