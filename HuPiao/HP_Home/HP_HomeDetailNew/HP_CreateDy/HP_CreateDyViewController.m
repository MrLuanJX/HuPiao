//
//  HP_CreateDyViewController.m
//  HuPiao
//
//  Created by a on 2019/6/18.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CreateDyViewController.h"

@interface HP_CreateDyViewController () <TZImagePickerControllerDelegate>

@property (nonatomic , strong) UIButton * backBtn;
// 相册
@property(nonatomic , strong) TZImagePickerController * photoalbum;

@end

@implementation HP_CreateDyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self openpHotoalbum];
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(HPScreenW/2, HPScreenH/2, HPFit(60), HPFit(60))];
    self.backBtn.backgroundColor = [UIColor greenColor];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.backBtn];
}

- (void) backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//打开相册
-(void)openpHotoalbum {
    
    __weak typeof (self) weakSelf = self;
    
    [self.photoalbum setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [weakSelf.navigationController popViewControllerAnimated:NO];
        
        NSLog(@"photos = %@",photos);
        
    }];
    [self presentViewController:self.photoalbum
                       animated:YES completion:nil];
    
}

-(TZImagePickerController *)photoalbum {
    if (_photoalbum == nil) {
        _photoalbum = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        _photoalbum.allowTakeVideo = NO;
        _photoalbum.allowPickingVideo = NO;
        _photoalbum.allowPickingGif = NO;
        _photoalbum.showSelectBtn = YES;
        _photoalbum.allowPickingOriginalPhoto = NO;
    }
    return _photoalbum;
}


@end
