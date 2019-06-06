//
//  HP_MineViewController.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/5/19.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//  http://www.miyizi.com
//  25bde0392eb77c7c597108469fb7a22037304c61

#import "HP_MineViewController.h"
#import "MUser.h"
#import "HP_HomeDetailNewViewController.h"
#import "HP_MineHeadView.h"
#import "HP_OwnMessageViewController.h"
#import "HP_CeIdcardViewController.h"
#import "HP_SignViewController.h"
#import "HP_FollowAndFansViewController.h"
#import "HP_WalletViewController.h"


static CGFloat const imageBGHeight = 200; // 背景图片的高度

@interface HP_MineViewController () <UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) MUser * user;

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray *dataArray;

@property (nonatomic , strong) HP_MineHeadView *headView;

@property (nonatomic , strong) NSMutableArray * messageList;

@property (nonatomic , strong) NSMutableArray * arr;
@property (nonatomic , strong) NSMutableArray * array;
@property (nonatomic , assign) CGFloat fileSize;

@end

@implementation HP_MineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];

    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    self.navigationItem.title = @"";
    
    [self.messageList removeAllObjects];
    [self.messageList addObjectsFromArray:[MUser findAll]];
    self.user = [self.messageList objectAtIndex:1];
    self.headView.user = self.user;
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self addTableView];

    [self addDataSource];
    
    [self foldFileSize];
}

#pragma mark -  重点的地方在这里 滚动时候进行计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = imageBGHeight + offsetY ;
    if (offsetH < 0) {
        CGRect frame = self.headView.frame;
        frame.size.height = imageBGHeight - offsetH;
        frame.origin.y = -imageBGHeight + offsetH;
        self.headView.frame = frame;
    }
    
    CGFloat alpha = offsetH / imageBGHeight;
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
//    self.titleLabel.alpha = alpha;
}

#pragma mark - 返回一张纯色图片
/** 返回一张纯色图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

- (void) foldFileSize {
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    self.fileSize = [self folderSizeAtPath:libPath];
}

- (void) addTableView {

    [self.view addSubview: self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.tableView addSubview: self.headView];
}

- (void) addDataSource {
    __weak typeof (self) weakSelf = self;

    /// 加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 3; i++) {
            [weakSelf.dataArray addObject:@""];
        }
        [self.tableView reloadData];
    });
    
    // 跳转个人主页
    self.headView.jumpOwnPage = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
//            MUser * user = [weakSelf.messageList objectAtIndex:0];
//            NSLog(@"user = %@",user);
            HP_HomeDetailNewViewController * detailVC = [HP_HomeDetailNewViewController suspendCenterPageVCWithUser:weakSelf.user IsOwn:YES];
            detailVC.title = weakSelf.user.name;
            [weakSelf.navigationController pushViewController:detailVC animated:YES];
        });
    };
    // 跳转个人资料页
    self.headView.jumpOwnMessagePage = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
//            MUser * user = [weakSelf.messageList objectAtIndex:0];
//            NSLog(@"user = %@",user);
            HP_OwnMessageViewController * ownMessageVC = [HP_OwnMessageViewController new];
            ownMessageVC.title = @"编辑资料";
            ownMessageVC.user = weakSelf.user;
            [weakSelf.navigationController pushViewController:ownMessageVC animated:YES];
        });
    };
    // 关注、粉丝、H币事件
    self.headView.followAction = ^(NSInteger tag) {
        if (tag == 0 || tag == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                HP_FollowAndFansViewController * followVC = [HP_FollowAndFansViewController new];
                followVC.title = tag == 0 ? @"我的关注" : @"我的粉丝";
                [weakSelf.navigationController pushViewController:followVC animated:YES];
            });
        }
       
        if (tag == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf jumpWalletVC];
            });
        }
    };
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 1 ? 10 : 0.00001;//50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   /* NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"与我亲密的",@"我的荣誉",@"主播形象",@"用户印象",@"个人资料",@"礼物柜",@"用户评价", nil];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    view.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    
    UILabel *  lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 5, 50 - 20)];
    lineLabel.backgroundColor = kSetUpCololor(R, G, B, 1.0);
    [view addSubview:lineLabel];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 40, 50)];
    titleLabel.text = arr[section];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = HPFontBoldSize(20);
    [view addSubview:titleLabel];
    
    return view;*/
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    
    return section == 0 ? [UIView new] : view;
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
    return section == 0 ? self.arr.count : self.array.count; //self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HPFit(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.font = HPFontSize(14);

    if (indexPath.section == 0) {
        cell.textLabel.text = self.arr[indexPath.row];
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"未认证";
        }
    } else {
        cell.textLabel.text = self.array[indexPath.row];
        if (indexPath.row == 0) {
           cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2lfM",self.fileSize];
        } else if (indexPath.row == 4){
            cell.detailTextLabel.text = APP_VERSION;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.userInteractionEnabled = NO;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HP_SignViewController * signVC = [HP_SignViewController new];
    HP_CeIdcardViewController * ceIdcardVC = [HP_CeIdcardViewController new];
    if (indexPath.section == 0 && indexPath.row == 1) {         // 身份认证
        ceIdcardVC.title = @"身份认证";
        [self.navigationController pushViewController:ceIdcardVC animated:YES];
    }

    if (indexPath.section == 1 && indexPath.row == 0) {         // 清理缓存
        [self clearFile];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        signVC.maxLength = 200;
        signVC.title = @"意见反馈";
        signVC.feedBack = YES;
        signVC.sendBtnTitle = @"提   交";
        [self.navigationController pushViewController:signVC animated:YES];
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self jumpWalletVC];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        INMAlertView * alertView = [INMAlertView new];
        alertView.dataArray = [NSMutableArray arrayWithObjects:@"五星好评",@"我要吐槽",@"残忍拒绝", nil];
        [alertView show];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.frame = [UIScreen mainScreen].bounds;
        _tableView.contentInset = UIEdgeInsetsMake(imageBGHeight, 0, self.tabBarController.tabBar.height, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (NSMutableArray *)messageList {
    if (!_messageList) {
        _messageList = @[].mutableCopy;
    }
    return _messageList;
}

- (HP_MineHeadView *)headView {
    if (!_headView) {
        _headView = [[HP_MineHeadView alloc] init]; // WithFrame:CGRectMake(0, 0, HPScreenW, HPFit(220))
        _headView.backgroundColor = [UIColor clearColor];
        _headView.frame = CGRectMake(0, -imageBGHeight, HPScreenW, imageBGHeight);
        _headView.userInteractionEnabled = YES;
        _headView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headView;
}

- (NSMutableArray *)arr {
    if (!_arr) {
        _arr = [NSMutableArray arrayWithObjects:@"我的钱包",@"身份认证",@"邀请好友", nil];
    }
    return _arr;
}
- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithObjects:@"清理缓存",@"意见反馈",@"五星好评",@"关于我们",@"当前版本", nil];
    }
    return _array;
}

- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

#pragma mark - 清理缓存
- (void) clearFile {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@", cachPath);
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog(@"files : %lu",(unsigned long)[files count]);
        
        for (NSString * p in files) {
            NSError *error;
            
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    });
}

-(void)clearCacheSuccess{
    NSLog(@"清理成功");
    [SVProgressHUD showSuccessWithStatus:@"清理成功"];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    self.fileSize = 0;
    [self.tableView reloadData];
}

/* 跳转钱包 */
- (void) jumpWalletVC {
    HP_WalletViewController * walletVC = [HP_WalletViewController new];
    walletVC.title = @"我的钱包";
    [self.navigationController pushViewController:walletVC animated:YES];
}

- (NSMutableAttributedString*)setUpmoney:(NSString *)money danwei:(NSString *)danwei{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",money,danwei]];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:HPUIColorWithRGB(0x333333, 1.0)
                range:NSMakeRange(0,[money length])];
    [str addAttribute:NSForegroundColorAttributeName
                value:kSetUpCololor(185, 185, 185, 1.0)
                range:NSMakeRange([money length],[danwei length])];
    
    [str addAttribute:NSFontAttributeName
                value:HPFontBoldSize(20)
                range:NSMakeRange(0, [money length])];
    [str addAttribute:NSFontAttributeName
                value:HPFontSize(16)
                range:NSMakeRange([money length], [danwei length])];
    
    
    return str;
}

@end