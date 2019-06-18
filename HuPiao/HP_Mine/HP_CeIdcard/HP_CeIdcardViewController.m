//
//  HP_CeIdcardViewController.m
//  HuPiao
//
//  Created by a on 2019/6/6.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CeIdcardViewController.h"
#import "HP_CerIdcardTabCell.h"
#import "AVCaptureViewController.h"
#import "JQAVCaptureViewController.h"
#import "IDInfo.h"

@interface HP_CeIdcardViewController () <UITableViewDataSource,UITableViewDelegate,TZImagePickerControllerDelegate>

@property(nonatomic , strong) UILabel * textLabel;
@property(nonatomic , strong) UITableView * tableView;
@property(nonatomic , strong) NSMutableArray * listData;
@property(nonatomic , strong) TZImagePickerController * photoalbum;
@property(nonatomic , strong) NSIndexPath * selectPath;
// 图片改变数组
@property(nonatomic , strong) NSMutableArray * changeImages;

@end

@implementation HP_CeIdcardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSubviews];
    [self createConstraint];
}
 
#pragma mark - private
-(void)createSubviews {
    [self.view addSubview:self.textLabel];
    [self.view addSubview:self.tableView];
}

-(void)createConstraint {
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(k_top_height + HPFit(10));
        make.left.mas_equalTo(HPFit(15));
        make.right.mas_equalTo(-HPFit(15));
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.textLabel.mas_bottom);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HP_CerIdcardTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCerIdcardTabCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
//    cell.model = self.listData[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;//self.listData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return section == 2 ? HPFit(15) : 0.0000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HPFit(15);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectPath = indexPath;

//    MyCertifIdCardMdoel *model = self.listData[indexPath.section];

    if (indexPath.section == 0) {
        // 身份证正面
        [self fontIDCardInfoAction];
//        [self fontIDCardInfoAction:model];
    }
    if (indexPath.section == 1) {
        //身份证反面
//        [self backIDCardInfoAction:model];
        [self backIDCardInfoAction];
    }
    if (indexPath.section == 2) {
        // 手持身份证
        [self didClickTakePhoto];
    }
}

- (void) fontIDCardInfoAction {
    __weak typeof (self) weakSelf = self;
    
    AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
    AVCaptureVC.CaptureInfo = ^(IDInfo *idInfo, UIImage *oriangImage, UIImage *subImage) {
        
    };
    
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}

#pragma mark 点击反面拍照
-(void) backIDCardInfoAction{
    
    JQAVCaptureViewController *JQAVCaptureVC = [[JQAVCaptureViewController alloc] init];
    
    JQAVCaptureVC.CaptureInfo = ^(IDInfo *idInfo, UIImage *oriangImage, UIImage *subImage) {
       
    };
    [self.navigationController pushViewController:JQAVCaptureVC animated:YES];
}

-(void)didClickTakePhoto {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:nil completion:nil];
        [self takePhoto];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:nil completion:nil];
        [self openpHotoalbum];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:nil completion:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

//打开相册
-(void)openpHotoalbum {
    __weak typeof (self) weakSelf = self;
    [self.photoalbum setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
       
    }];
    [self presentViewController:self.photoalbum
                       animated:YES completion:nil];
}

//打开相机
-(void)takePhoto {
    __weak typeof (self) weakSelf = self;
    Lyy_ImagePickerController *controlelr = [[Lyy_ImagePickerController alloc]init];
    controlelr.presentViewController = self;
    controlelr.finishCallback = ^(UIImage * _Nonnull img,PHAsset *asset) {
       
    };
    [controlelr takePhoto];
}

-(UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
        _textLabel.numberOfLines = 0;
        _textLabel.font = HPFontSize(14);
        _textLabel.textColor = HPSubTitleColor;
        _textLabel.text = @"请确保所有数据清晰可读，避免出现反光，不模糊。";
    }
    return _textLabel;
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[HP_CerIdcardTabCell class] forCellReuseIdentifier:@"MyCerIdcardTabCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = HPFit(185);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(TZImagePickerController *)photoalbum {
    if (_photoalbum == nil) {
        _photoalbum = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        _photoalbum.allowTakeVideo = NO;
        _photoalbum.allowPickingVideo = NO;
        _photoalbum.allowPickingGif = NO;
        _photoalbum.showSelectBtn = YES;
    }
    return _photoalbum;
}


@end
