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
#import "HP_AuthMessageHeadView.h"

@interface HP_OwnMessageViewController () <TZImagePickerControllerDelegate>

@property (nonatomic , strong) HP_AuthOwnView * authOwnView;

@property (nonatomic , strong) HP_NormalOwnView * normalOwnView;
// 身高、体重
@property (nonatomic , strong) NSMutableArray * heightArr;
@property (nonatomic , strong) NSMutableArray * weightArr;
// 职业、兴趣
@property (nonatomic , strong) NSMutableArray * jobArr;
@property (nonatomic , strong) NSMutableArray * interestArr;
// 相册
@property (nonatomic , strong) TZImagePickerController * photoalbum;

@property (nonatomic , strong) HP_AuthCollectCell * authCollectCell;

@end

@implementation HP_OwnMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageLogStr = @"MaterialPage";
    
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
        [wSelf didClickTakePhotoWithNormalView:YES];
    };
    // 提交
    self.normalOwnView.commitClickBlock = ^{
        NSLog(@"normalCommitAction");
    };
#pragma mark - authView
    // tableViewCell 点击事件
    self.authOwnView.cellSeleteBlock = ^(NSIndexPath * _Nonnull index, UITableViewCell * _Nonnull cell) {
        // cell点击事件
        [wSelf didSeletedCellWithIndex:index WithCell:cell];
    };
    // collectionViewCell 点击事件
    self.authOwnView.collectSeleteBlock = ^(NSIndexPath * _Nonnull index, HP_AuthCollectCell * _Nonnull cell) {
        NSLog(@"当前点击了第%ld个item",index.item);
        wSelf.authCollectCell = cell;
        [wSelf didClickTakePhotoWithNormalView:NO];
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
        NSArray * jobTitleArr = @[@"高管",@"创始人",@"职业经理人",@"咨询顾问",@"市场",@"产品",@"运营",@"销售",@"技术",@"客服",@"商务",@"公关",@"人事",@"行政",@"法务",@"设计",@"策划",@"编辑",@"健身教练",@"空乘",@"公务员",@"分析师",@"创始人",@"翻译",@"科研人员",@"作家",@"律师",@"社会工作者",@"自由职业者",@"医生",@"护士",@"教师",@"无"];
        for (int i = 0; i < jobTitleArr.count; i++) {
            NSDictionary * jobDict = @{
                                    @"index" : [NSString stringWithFormat:@"%d",i],
                                    @"title" : jobTitleArr[i],
                                    @"seleted" : @"0"
                                    };
            [_jobArr addObject:jobDict];
        }
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
#pragma mark - 个性签名
        signVC.signBlock = ^(NSString * _Nonnull signature) {
            cell.detailTextLabel.numberOfLines = 2;
            cell.detailTextLabel.text = signature;
        };
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
    seleteVC.jobSeleteBlock = ^(NSIndexPath * _Nonnull index, NSMutableArray * _Nonnull seleteItem) {
        for (int i = 0; i < seleteItem.count; i++) {
            NSDictionary * dict = seleteItem[i];
            if ([dict[@"seleted"] isEqualToString:@"1"]) {
                cell.detailTextLabel.text = dict[@"title"];
            }
        }
    };
    // 兴趣回调
    seleteVC.interestSeleteBlock = ^(NSIndexPath * _Nonnull index, NSArray * _Nonnull seleteTitles) {
        for (int i = 0; i < seleteTitles.count; i++) {
            NSDictionary * dict = seleteTitles[i];
            if ([dict[@"seleted"] isEqualToString:@"1"]) {
                cell.detailTextLabel.text = dict[@"title"];
            }
        }
    };
    [self.navigationController pushViewController:seleteVC animated:YES];
}

#pragma mark - property
-(TZImagePickerController *)photoalbum {
    if (_photoalbum == nil) {
        _photoalbum = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        _photoalbum.allowTakeVideo = NO;
        _photoalbum.allowPickingVideo = NO;
        _photoalbum.allowPickingGif = NO;
        _photoalbum.showSelectBtn = YES;
        _photoalbum.allowTakeVideo = NO;
        _photoalbum.showSelectBtn = YES;
        _photoalbum.allowCameraLocation = NO;
        _photoalbum.allowTakePicture = NO;
        _photoalbum.showSelectedIndex = YES;
        _photoalbum.preferredLanguage = @"zh-Hans";
        _photoalbum.allowPickingOriginalPhoto = NO;
    }
    return _photoalbum;
}

- (void)didClickTakePhotoWithNormalView:(BOOL) isNormalView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhotoWithNormalView:isNormalView];           // 拍照
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openpHotoalbumWithNormalView:isNormalView];      // 相册
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    [self presentViewController:alert animated:YES completion:nil];
}

//打开相册
-(void)openpHotoalbumWithNormalView:(BOOL) isNormalView {
    __weak typeof (self) weakself = self;
    [self.photoalbum setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (isNormalView == YES) {
            [weakself uploadImage:photos[0] WithNormalView:isNormalView];
        } else {
            [weakself uploadImage:photos];
        }
    }];
    [self presentViewController:self.photoalbum
                       animated:YES completion:nil];
}

-(void)uploadImage:(NSArray *)image {
    NSMutableArray * arr = [NSMutableArray arrayWithArray:image];
    self.authOwnView.dataSource = arr;
}

//上传图片
-(void)uploadImage:(UIImage *)image WithNormalView:(BOOL) isNormalView {
    if (isNormalView == YES) {
        [self.normalOwnView iconBtnUpdateImageWithImage:image];
    } else {
        self.authCollectCell.image.image = image;
    }
}

//打开相机
-(void)takePhotoWithNormalView:(BOOL) isNormalView {
    Lyy_ImagePickerController *controlelr = [[Lyy_ImagePickerController alloc]init];
    controlelr.presentViewController = self;
    __weak typeof (self) weakself = self;
    controlelr.finishCallback = ^(UIImage * _Nonnull img,PHAsset *asset) {
        [weakself uploadImage:img WithNormalView:isNormalView];
    };
    [controlelr takePhoto];
}

@end
