//
//  HP_CreateDyCell.m
//  HuPiao
//
//  Created by a on 2019/6/18.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CreateDyCell.h"

static int maxLength = 200;

@interface HP_CreateDyCollectCell ()

@property (nonatomic , strong) UIImageView * bgImg;

@property (nonatomic , strong) UIImage * img;

@property (nonatomic, strong) id asset;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) NSInteger row;


@end

@implementation HP_CreateDyCollectCell

- (void)setImg:(UIImage *)img {
    _img = img;
    
    self.bgImg.image = img;
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        __weak typeof (self) weakSelf = self;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2.0f;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.bgImg];
        [self.contentView addSubview: self.deleteBtn];
        
        [self.bgImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.top.left.mas_equalTo(0);
        }];
        
        [self.deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(weakSelf.bgImg);
        }];
    }
    return self;
}

- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        [_bgImg setClipsToBounds:YES];
    }
    return _bgImg;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton new];
        [_deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

@end

@interface HP_CreateDyCell() <UITextViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UITextView * textView;
@property (nonatomic , strong) UILabel * stringlenghtLab;
@property (nonatomic , strong) UILabel * descLab;

@property (nonatomic , strong) NSMutableArray * dataSource;

@end

@implementation HP_CreateDyCell

- (void)setSelectedPhotos:(NSMutableArray *)selectedPhotos {
    _selectedPhotos = selectedPhotos;

}

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    HP_CreateDyCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_CreateDyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self configUI];
        
    }
    return self;
}

- (void) configUI{
    WS(wSelf);
    [self.contentView addSubview: self.textView];
    [self.textView addSubview:self.descLab];
    [self.contentView addSubview: self.stringlenghtLab];
    [self.contentView addSubview: self.collectionView];
    
    
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(HPFit(15));
        make.right.mas_equalTo (-HPFit(15));
        make.height.mas_equalTo(HPFit(200));
    }];
    
    [self.descLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(HPFit(7));
        make.right.mas_equalTo(wSelf.textView.mas_right);
        make.height.mas_equalTo(HPFit(20));
    }];
    
    [self.stringlenghtLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.textView.mas_bottom);
        make.left.mas_equalTo (wSelf.textView.mas_left);
        make.height.mas_equalTo (HPFit(20));
        
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (wSelf.stringlenghtLab.mas_bottom).offset (HPFit(15));
        make.left.right.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo ((HPScreenW - HPFit(30))/3 * 3 + HPFit(30));

        make.bottom.mas_equalTo (wSelf.contentView.mas_bottom).offset(-HPFit(15));
    }];
}

-(void)textViewDidChange:(UITextView *)textView{
    self.descLab.hidden = YES;
    
    //字数限制
    if (textView.text.length >= maxLength) {
        textView.text = [textView.text substringToIndex:maxLength];
    }
    
    //实时显示字数
    self.stringlenghtLab.text = [NSString stringWithFormat:@"%ld/%d",(long)textView.text.length,maxLength];
    
    //取消按钮点击权限，并显示文字
    if (textView.text.length == 0) {
        self.descLab.hidden = NO;
      
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        
        [self.textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.selectedPhotos.count >= 9) {
        return self.selectedPhotos.count;
    } else {
        for (PHAsset *asset in self.selectedAssets) {
            if (asset.mediaType == PHAssetMediaTypeVideo) {
                return self.selectedPhotos.count;
            }
        }
    }
    return self.selectedPhotos.count + 1;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_CreateDyCollectCell * collectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"createCollectCell" forIndexPath:indexPath];
    
    if (indexPath.item == self.selectedPhotos.count) {
        collectCell.bgImg.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        collectCell.deleteBtn.hidden = YES;
    } else {
        collectCell.deleteBtn.hidden = NO;
        collectCell.bgImg.image = self.selectedPhotos[indexPath.item];
        collectCell.asset = self.selectedAssets[indexPath.item];
    }
    collectCell.deleteBtn.tag = indexPath.item;
    [collectCell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    return collectCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.selectedPhotos.count) {
        if (self.photoClickAction) {
            self.photoClickAction(indexPath);
        }
    } else {
        if (self.photoPreviewAction) {
            self.photoPreviewAction(indexPath , self.selectedPhotos , self.selectedAssets);
        }
    }
}

- (void) reload {
    [self.collectionView reloadData];
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = HPFontSize(14);
        _textView.delegate = self;
    }
    return _textView;
}

- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [UILabel new];
        _descLab.text = @"这一刻的想法...";
        _descLab.font = HPFontSize(14);
        _descLab.textColor = HPUIColorWithRGB(0xC1C1C1, 1.0);
    }
    return _descLab;
}

- (UILabel *)stringlenghtLab {
    if (!_stringlenghtLab) {
        _stringlenghtLab = [UILabel new];
        _stringlenghtLab.font = HPFontSize(13);
        _stringlenghtLab.textColor = [UIColor lightGrayColor];
        _stringlenghtLab.textAlignment = NSTextAlignmentRight;
        _stringlenghtLab.text = [NSString stringWithFormat:@"0/%d",maxLength];
    }
    return _stringlenghtLab;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 行间距
        layout.minimumLineSpacing = HPFit(5);
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake((HPScreenW - HPFit(30))/3, (HPScreenW - HPFit(30))/3);
        layout.sectionInset = UIEdgeInsetsMake(HPFit(10), HPFit(10), HPFit(10), HPFit(10)); //设置距离上 左 下 右
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HP_CreateDyCollectCell class] forCellWithReuseIdentifier:@"createCollectCell"];
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

// 删除
- (void) deleteBtnClik:(UIButton *) sender{
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= self.selectedPhotos.count) {
        [self.selectedPhotos removeObjectAtIndex:sender.tag];
        [self.selectedAssets removeObjectAtIndex:sender.tag];
        [self.collectionView reloadData];
        return;
    }
    [self.selectedPhotos removeObjectAtIndex:sender.tag];
    [self.selectedAssets removeObjectAtIndex:sender.tag];
    [self.collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_collectionView reloadData];
    }];
}

@end
