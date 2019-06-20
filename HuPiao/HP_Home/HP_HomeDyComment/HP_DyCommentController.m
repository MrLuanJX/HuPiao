//
//  HP_DyCommentController.m
//  HuPiao
//
//  Created by a on 2019/6/19.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_DyCommentController.h"
#import "HP_DyCell.h"
#import <IQKeyboardManager.h>
#import "HP_CommentCell.h"

@interface HP_DyCommentController () <UITableViewDelegate , UITableViewDataSource , XBZChatKeyBoardViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) NSMutableArray * dataArray;
// 键盘
@property (nonatomic, strong) XBZChatKeyBoardView *keyBoardView;

@end

@implementation HP_DyCommentController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    IQKeyboardManager.sharedManager.enable = NO;
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addTableView];
    
    [self initArray];
}

- (void) initArray {
    WS(wSelf);
    self.dataSource = @[].mutableCopy;
    /// 加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 30; i++) {
            [wSelf.dataSource addObject:@""];
        }
        [self.tableView reloadData];
    });
}

- (void) addTableView {
    [self.view addSubview: self.tableView];
    [self.view addSubview:self.keyBoardView];

    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (k_top_height);
        make.left.right.mas_equalTo (0);
        make.bottom.equalTo(self.keyBoardView.mas_top);
    }];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
//     [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  section == 0 ? 0.00001 : HPFit(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    view.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    
    UIView * commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HPScreenW, HPFit(50))];
    commentView.backgroundColor = [UIColor whiteColor];
    
    UIView * grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, commentView.width, HPFit(10))];
    grayView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    [commentView addSubview:grayView];
    
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(grayView.frame) + HPFit(10), HPFit(5), commentView.height - HPFit(30))];
    line.backgroundColor = HPUIColorWithRGB(0x3A5FCD, 1.0);
    [commentView addSubview:line];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(HPFit(20), CGRectGetMaxY(grayView.frame), commentView.width - HPFit(40), commentView.height - HPFit(10))];
    title.font = HPFontBoldSize(20);
    title.textColor = [UIColor blackColor];
    title.text = @"热门评论";
    [commentView addSubview:title];

    return section == 0 ? [UIView new] : commentView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.dyModel.rowHeight;
    } else {
        return HPFit(70);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        static NSString *CellIdentifier = @"dyCell";
        
        HP_DyCell * dyCell = [HP_DyCell dequeueReusableCellWithTableView:tableView Identifier:CellIdentifier];
        
        dyCell.index = indexPath;
        
        dyCell.dyModel = self.dyModel;
        
        return dyCell;
    } else {
//        HP_CommentCell * commentCell = [HP_CommentCell dequeueReusableCellWithTableView:tableView Identifier:@"commentCell"];
//        commentCell.userInteractionEnabled = NO;
//        return commentCell;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        if ([self.dataArray[indexPath.row] isKindOfClass:[NSString class]]) {
            cell.textLabel.text = self.dataArray[indexPath.row];
        }else {
            cell.textLabel.attributedText = self.dataArray[indexPath.row];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //    BaseViewController *baseVC = [BaseViewController new];
    //    baseVC.title = @"二级页面";
    //    [self.navigationController pushViewController:baseVC animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.keyBoardView hideBottomView];
}

//MARK: - XBZChatKeyBoardViewDelegate
- (void)chatKeyBoardViewSelectMoreImteTitle:(NSString *)title index:(NSInteger)index {
}
- (void)chatKeyBoardViewSendPhotoMessage:(nonnull NSString *)photo {
    
}
- (void)chatKeyBoardViewSendVoiceMessage:(nonnull NSString *)voicePath {
    
}

- (void)chatKeyBoardViewSendTextMessage:(nonnull NSMutableAttributedString *)text originText:(nonnull NSString *)originText {
    
//    [self requestInsertDataWithText:originText];
    [self addCommentWithText:originText];
}
// 新增评论
- (void) addCommentWithText :(NSString *)text {
    
    [self.dataArray addObject:text];
    [self.tableView reloadData];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self.keyBoardView hideBottomView];
}

//MARK: - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize size = [change[NSKeyValueChangeNewKey] CGSizeValue];
        if (size.height > self.tableView.height) {
            [self.tableView scrollToBottomAnimated:YES];
        }
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    }
    return _tableView;
}

- (XBZChatKeyBoardView *)keyBoardView {
    if (!_keyBoardView) {
        _keyBoardView = [[XBZChatKeyBoardView alloc] initWithNavigationBarTranslucent:YES];
        _keyBoardView.delegate = self;
        _keyBoardView.showVoice = NO;
        _keyBoardView.showFace = NO;
        _keyBoardView.showMore = NO;
    }
    return _keyBoardView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

@end
