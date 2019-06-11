//
//  HPCircleCollectionCell.m
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_CircleTableCell.h"

@interface HP_CircleTableCell()

@property (nonatomic , strong) UICollectionView * collectionView;

@end

@implementation HP_CircleTableCell

// 创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
    
    HP_CircleTableCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HP_CircleTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];//kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configUI];
        
        [self createConstrainte];
    }
    return self;
}

- (void) configUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 行间距
    layout.minimumLineSpacing = HPFit(40);
    layout.minimumInteritemSpacing = HPFit(30);
    //设置每个item的大小
    layout.itemSize = CGSizeMake((HPScreenW - HPFit(20))/1.5, HPFit(240));
    layout.sectionInset = UIEdgeInsetsMake(HPFit(10), HPFit(20), HPFit(10), HPFit(20)); //设置距离上 左 下 右
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
//    [collectionView registerClass:[LJX_XZCollectionCell class] forCellWithReuseIdentifier:@"xzCollectCell"];
    collectionView.backgroundColor = HPUIColorWithRGB(0xffffff, 1.0);
    self.collectionView = collectionView;
    [self.contentView addSubview:collectionView];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (HPFit(5));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (-HPFit(5));
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.contentView.mas_top).mas_offset (HPFit(10));
        make.left.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(HPFit(260));
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset (-HPFit(10));
    }];
    
    [self.collectionView reloadData];
}
@end
