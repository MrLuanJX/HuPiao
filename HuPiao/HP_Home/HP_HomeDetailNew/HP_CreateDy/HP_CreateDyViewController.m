//
//  HP_CreateDyViewController.m
//  HuPiao
//
//  Created by a on 2019/6/18.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CreateDyViewController.h"
#import "HP_CreateDyCell.h"
#import "HP_HomeDetailNewViewController.h"

@interface HP_CreateDyViewController () <UITableViewDelegate , UITableViewDataSource , TZImagePickerControllerDelegate , UIImagePickerControllerDelegate , UIAlertViewDelegate , UINavigationControllerDelegate>

@property (nonatomic , strong) UIButton * backBtn;

@property (nonatomic , strong) UITableView * tableView;

@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@end

@implementation HP_CreateDyViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏背景图片为一个无图的image，导航栏会加载空imgae，就自然透明掉了
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    //同理透明掉导航栏下划线
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = @"发布动态";
    
    [self addTableView];
    
    [self setupNavBtn];    
}

- (void) addTableView {
    WS(wSelf);
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(wSelf.view);
    }];
}

- (void) setupNavBtn {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(cancelAction) Title:@"取消" TitleColor:HPUIColorWithRGB(0x666666, 1.0)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(createNowAction) Title:@"发布" TitleColor:HPUIColorWithRGB(0x666666, 1.0)];
}

- (void) cancelAction {
    NSLog(@"取消");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) createNowAction {
    NSLog(@"发布");
}

#pragma mark - UITableViewDelegate  UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return  [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(wSelf);
    
    HP_CreateDyCell * cell = [HP_CreateDyCell dequeueReusableCellWithTableView:tableView Identifier:@"createDyCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.selectedPhotos = self.selectedPhotos;
    
    cell.selectedAssets = self.selectedAssets;

    // 添加图片
    cell.photoClickAction = ^(NSIndexPath * _Nonnull index) {
        [wSelf showAlertController];
    };
    
    __weak HP_CreateDyCell* wselfCell = cell;
    
    // 照片预览
    cell.photoPreviewAction = ^(NSIndexPath * _Nonnull index, NSMutableArray * _Nonnull photos, NSMutableArray * _Nonnull assets) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:assets selectedPhotos:photos index:indexPath.item];
        imagePickerVc.maxImagesCount = 9;
        imagePickerVc.allowPickingGif = NO;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.allowPickingMultipleVideo = NO;
        imagePickerVc.showSelectedIndex = YES;
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            wSelf.selectedPhotos = [NSMutableArray arrayWithArray:photos];
            wSelf.selectedAssets = [NSMutableArray arrayWithArray:assets];
            [wselfCell reload];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    };
    
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.frame = [UIScreen mainScreen].bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[HP_CreateDyCell class] forCellReuseIdentifier:@"createDyCell"];
    }
    return _tableView;
}

#pragma mark - Private
/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
        // NSLog(@"图片名字:%@",fileName);
    }
}

//打开相册
-(void)openpHotoalbum {
    
    __weak typeof (self) weakSelf = self;
    self.againPhotoalbum = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    self.againPhotoalbum.allowTakeVideo = NO;
    self.againPhotoalbum.allowPickingVideo = NO;
    self.againPhotoalbum.allowPickingGif = NO;
    self.againPhotoalbum.showSelectBtn = YES;
    self.againPhotoalbum.allowCameraLocation = NO;
    self.againPhotoalbum.allowTakePicture = NO;
    self.againPhotoalbum.showSelectedIndex = YES;
    self.againPhotoalbum.preferredLanguage = @"zh-Hans";
    self.againPhotoalbum.selectedAssets = _selectedAssets;

    [self presentViewController:self.againPhotoalbum
                       animated:YES completion:nil];
}

#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self openPhoto];
    }
}

// 调用相机
- (void)openPhoto {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
    
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

#pragma mark - 相机
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                // 允许裁剪,去裁剪
                TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                    [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                }];
                imagePicker.allowPickingImage = YES;
                imagePicker.needCircleCrop = YES;
                imagePicker.circleCropRadius = 100;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    NSArray <HP_CreateDyCell *> *cellArray = [self.tableView visibleCells];
    if (cellArray) {
        HP_CreateDyCell *cell = (HP_CreateDyCell *)[cellArray firstObject];
        cell.selectedPhotos = self.selectedPhotos;
        cell.selectedAssets = self.selectedAssets;
        [cell reload];
    }
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

#pragma mark - 相册
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
    
    NSArray <HP_CreateDyCell *> *cellArray = [self.tableView visibleCells];
    if (cellArray) {
        HP_CreateDyCell *cell = (HP_CreateDyCell *)[cellArray firstObject];
        cell.selectedPhotos = self.selectedPhotos;
        cell.selectedAssets = self.selectedAssets;
        [cell reload];
    }
}

- (void) showAlertController {
    WS(wSelf);
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wSelf takePhoto];
    }];
    [alertVc addAction:takePhotoAction];
    UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [wSelf openpHotoalbum];
    }];
    [alertVc addAction:imagePickerAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:cancelAction];
    
    [wSelf presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - 弹出视图
- (void) configPopView {
    
    __weak typeof (self) weakSelf = self;
    
    NSArray *titles = @[@"相册", @"拍照"];
    
    NSMutableArray *imgs = @[].mutableCopy;
    for (NSInteger i = 0; i < titles.count; i ++) {
        [imgs addObject:[NSString stringWithFormat:@"publish_%zi", i]];
    }
    [LLWPlusPopView showWithImages:imgs titles:titles selectBlock:^(NSInteger index) {
        NSLog(@"index:%zi", index);
        
        if (index == 0) {
            [weakSelf openpHotoalbum];
        } else if (index == 1) {
            [weakSelf takePhoto];
        }
    } view:self.view] ;
}


@end
