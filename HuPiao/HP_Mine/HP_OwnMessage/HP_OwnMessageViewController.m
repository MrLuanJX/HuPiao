//
//  HP_OwnMessageViewController.m
//  HuPiao
//
//  Created by a on 2019/6/5.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_OwnMessageViewController.h"
#import "HP_AuthOwnView.h"
#import "HP_NormalOwnView.h"
#import "HP_SeleteViewController.h"
#import "HP_SignViewController.h"
#import "HP_UpdateNickNameViewController.h"

@interface HP_OwnMessageViewController ()

@property (nonatomic , strong) HP_AuthOwnView * authOwnView;

@property (nonatomic , strong) HP_NormalOwnView * normalOwnView;
// 身高、体重
@property (nonatomic , strong) NSMutableArray * heightArr;
@property (nonatomic , strong) NSMutableArray * weightArr;
@property (nonatomic , strong) NSMutableArray * jobArr;
@property (nonatomic , strong) NSMutableArray * interestArr;

@end

@implementation HP_OwnMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    self.normalOwnView.user = self.user;
    self.authOwnView.user = self.user;
}

- (void) setupUI {
    WS(wSelf);
    [self.view addSubview: self.normalOwnView];
    [self.view addSubview: self.authOwnView];
    [self.authOwnView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (wSelf.view);
    }];
    [self.normalOwnView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (wSelf.view);
    }];
#pragma mark - normalView
    // 点击头像
    self.normalOwnView.iconClickBlock = ^{
        NSLog(@"点击头像");
    };
    // 提交
    self.normalOwnView.commitClickBlock = ^{
        NSLog(@"normalCommitAction");
    };
#pragma mark - authView
    self.authOwnView.cellSeleteBlock = ^(NSIndexPath * _Nonnull index, UITableViewCell * _Nonnull cell) {
        // cell点击事件
        [wSelf didSeletedCellWithIndex:index WithCell:cell];
    };
}

- (HP_AuthOwnView *)authOwnView {
    if (!_authOwnView) {
        _authOwnView = [HP_AuthOwnView new];
        _authOwnView.hidden = NO;
    }
    return _authOwnView;
}

- (HP_NormalOwnView *)normalOwnView {
    if (!_normalOwnView) {
        _normalOwnView = [HP_NormalOwnView new];
        _normalOwnView.hidden = YES;
    }
    return _normalOwnView;
}
// 身高
- (NSMutableArray *)heightArr {
    if (!_heightArr) {
        _heightArr = [NSMutableArray array];
        for (int i = 0; i <= 110; i++) {
            NSString * str = [NSString stringWithFormat:@"%d",i+140];
            [_heightArr addObject:str];
        }
    }
    return _heightArr;
}
// 体重
- (NSMutableArray *)weightArr {
    if (!_weightArr) {
        _weightArr = [NSMutableArray array];
        for (int i = 0; i <= 110; i++) {
            NSString * str = [NSString stringWithFormat:@"%d",i+40];
            [_weightArr addObject:str];
        }
    }
    return _weightArr;
}
// 职业
- (NSMutableArray *)jobArr {
    if (!_jobArr) {
        _jobArr = [NSMutableArray array];
        _jobArr = [NSMutableArray arrayWithObjects:@"高管",@"创始人",@"职业经理人",@"咨询顾问",@"市场",@"产品",@"运营",@"销售",@"技术",@"客服",@"商务",@"公关",@"人事",@"行政",@"法务",@"设计",@"策划",@"编辑",@"健身教练",@"空乘",@"公务员",@"分析师",@"创始人",@"翻译",@"科研人员",@"作家",@"律师",@"社会工作者",@"自由职业者",@"医生",@"护士",@"教师",@"无", nil];
        /*
        NSArray * jobTitleArr = @[@"高管",@"创始人",@"职业经理人",@"咨询顾问",@"市场",@"产品",@"运营",@"销售",@"技术",@"客服",@"商务",@"公关",@"人事",@"行政",@"法务",@"设计",@"策划",@"编辑",@"健身教练",@"空乘",@"公务员",@"分析师",@"创始人",@"翻译",@"科研人员",@"作家",@"律师",@"社会工作者",@"自由职业者",@"医生",@"护士",@"教师",@"无"];
        for (int i = 0; i < jobTitleArr.count; i++) {
            NSDictionary * jobDict = @{
                                    @"index" : [NSString stringWithFormat:@"%d",i],
                                    @"title" : jobTitleArr[i],
                                    @"seleted" : @"0"
                                    };
            [_jobArr addObject:jobDict];
        }*/
    }
    return _jobArr;
}
// 兴趣
- (NSMutableArray *)interestArr {
    if (!_interestArr) {
        _interestArr = [NSMutableArray array];
        NSArray * titleArr = @[@"唱歌",@"旅行",@"摄影",@"撩汉",@"音乐",@"追剧",@"酒友",@"电影迷",@"夜店文化",@"精通厨艺",@"纹身爱好者",@"数码控",@"夜猫子",@"果粉",@"吃货",@"吸猫",@"撸狗",@"游戏",@"王者荣耀",@"二次元",@"狼人杀",@"绝地求生",@"英雄联盟",@"Live House",@"手工",@"绘画",@"写作",@"阅读",@"护肤",@"绿植",@"自驾游",@"跳舞",@"无"];
        for (int i = 0; i < titleArr.count; i++) {
            NSDictionary * dict = @{
                                    @"index" : [NSString stringWithFormat:@"%d",i],
                                    @"title" : titleArr[i],
                                    @"seleted" : @"0"
                                    };
            [_interestArr addObject:dict];
        }
    }
    return _interestArr;
}

#pragma mark - cell单击事件
- (void) didSeletedCellWithIndex:(NSIndexPath *)index WithCell:(UITableViewCell *)cell {
    HP_UpdateNickNameViewController * nickNameVC = [HP_UpdateNickNameViewController new];
    HP_SignViewController * signVC = [HP_SignViewController new];
    if (index.row == 1) {
        // 开始展示时间（最小时间-选择器第一个）
        NSDate *minDate = [NSDate br_setYear:1900 month:1 day:01];
        // 结束时间 （最大时间-选择器最后一个）
        NSDate *maxDate = [NSDate date];
        [BRDatePickerView showDatePickerWithTitle:@"请选择出生日期" dateType:BRDatePickerModeYMD defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
            // 选中结果
            cell.detailTextLabel.text = selectValue;
        } cancelBlock:^{
            NSLog(@"点击了背景或取消按钮");
        }];
    }
    if (index.row == 2 || index.row == 3) {
        [self showPickerViewWithTitle:index.row == 2 ? @"请选择身高(单位：cm)" : @"请选择体重(单位：kg)" DataSource:index.row == 2 ? self.heightArr : self.weightArr WithCell:cell index:index];
    }
    if (index.row == 4 || index.row == 5) {
        [self jumpSeleteControllerWithIndex:index WithCell:cell];
    }
    if (index.row == 6) {
        signVC.maxLength = 100;
        signVC.title = @"个性签名";
        signVC.feedBack = NO;
        signVC.sendBtnTitle = @"保   存";
        [self.navigationController pushViewController:signVC animated:YES];
    }
    if (index.row == 0) {
        nickNameVC.user = self.user;
        nickNameVC.title = self.user.name;
        [self.navigationController pushViewController:nickNameVC animated:YES];
    }
}
// 弹出选择器
- (void) showPickerViewWithTitle :(NSString *) title DataSource:(NSMutableArray *)dataSource WithCell:(UITableViewCell *)cell index:(NSIndexPath *)index {
    [BRStringPickerView showStringPickerWithTitle:title dataSource:dataSource defaultSelValue:@"" isAutoSelect:NO themeColor:nil resultBlock:^(id selectValue) {
        
        cell.detailTextLabel.text = index.row == 2 ? [NSString stringWithFormat:@"%@cm",selectValue] : [NSString stringWithFormat:@"%@kg",selectValue];
    } cancelBlock:^{
        NSLog(@"点击了背景视图或取消按钮");
    }];
}
// 跳转选择器
- (void) jumpSeleteControllerWithIndex:(NSIndexPath *)index WithCell:(UITableViewCell *)cell {
    HP_SeleteViewController * seleteVC = [HP_SeleteViewController new];
    seleteVC.dataArray =  index.row == 5 ? self.jobArr : self.interestArr;
    seleteVC.isJob = index.row == 5 ? YES : NO;
    seleteVC.title = index.row == 5 ? @"职业" : @"兴趣";

    // 职业回调
    seleteVC.jobSeleteBlock = ^(NSIndexPath * _Nonnull index, NSString * _Nonnull seleteTitle) {
        cell.detailTextLabel.text = seleteTitle;
    };
    // 兴趣回调
    seleteVC.interestSeleteBlock = ^(NSArray * _Nonnull seleteTitles) {
        NSMutableArray * seletedArr = @[].mutableCopy;
        for (int i = 0; i < seleteTitles.count; i++) {
            NSDictionary * dict = seleteTitles[i];
            if ([dict[@"seleted"] isEqualToString:@"1"]) {
                [seletedArr addObject:dict[@"title"]];
            }
        }
      cell.detailTextLabel.text = [seletedArr componentsJoinedByString:@","];
    };
    
    [self.navigationController pushViewController:seleteVC animated:YES];
}

@end
