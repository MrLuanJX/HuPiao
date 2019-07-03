//
//  HP_UserImpressionViewController.m
//  HuPiao
//
//  Created by a on 2019/6/24.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_UserImpressionViewController.h"
#import "JYEqualCellSpaceFlowLayout.h"

@interface HP_UserImpressionCell ()

@property (nonatomic , strong) UILabel * title;

@property (nonatomic , copy) NSString * text;

@end

@implementation HP_UserImpressionCell

- (void)setText:(NSString *)text {
    _text = text;
    
    self.title.text = text;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    [self addSubview: self.title];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (self);
    }];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.title setBorderWithCornerRadius:self.title.height/2 borderWidth:0 borderColor:HPClearColor type:UIRectCornerAllCorners];
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        _title.backgroundColor = kSetUpCololor(R, G, B, 1.0);
        
        _title.font = HPFontSize(15);
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = HPUIColorWithRGB(0xffffff, 1.0);
    }
    return _title;
}

#pragma mark — 实现自适应文字宽度的关键步骤:item的layoutAttributes
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{

    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    CGRect rect = [self.title.text boundingRectWithSize:CGSizeMake(HPScreenW - HPFit(20), HPFit(30)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: HPFontSize(15)} context:nil];
    rect.size.height+= HPFit(10);
    rect.size.width += rect.size.height *1.5;
    attributes.frame = rect;

    return attributes;
}

@end

@interface HP_UserImpressionViewController () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) NSMutableArray * dataSource;

@property (nonatomic , strong) NSMutableArray * selectedArray;

@end

@implementation HP_UserImpressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addViews];
    
    [self createConstraint];
    
    [self.title isEqualToString:@"立即评价"] ? [self setupRightNav] : nil;
}

- (void) setupRightNav {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(commitAction) Title:@"提交" TitleColor:HPUIColorWithRGB(0x333333, 1.0)];
}

- (void) commitAction {
    NSLog(@"提交");
    
    NSLog(@"selectedArray = %@",self.selectedArray);
}

- (void) addViews {
    [self.view addSubview: self.collectionView];
}

-(void)createConstraint {
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (HPFit(15));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.csoLabelColl.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HP_UserImpressionCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"uimCollectCell" forIndexPath:indexPath];
    
    collectionCell.text = self.csoLabelColl[indexPath.item];
    
    return collectionCell;
}

#pragma mark - 返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.selectedArray.count >= 2) {
//        [WHToast showMessage:@"最多只能选择2条评价" duration:1.5 finishHandler:^{
//            NSLog(@"省略n行代码");
//        }];
//        return;
//    }
//    
//    HP_UserImpressionCell * cell = (HP_UserImpressionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//
//    cell.title.attributedText = [HP_Label setUpFirstStr:@"√  " FirstColor:HPUIColorWithRGB(0xffffff, 1.0) FirstFont:HPFontSize(15) SecondStr:cell.title.text SecondColor:HPUIColorWithRGB(0xffffff, 1.0) SecondFont:HPFontSize(15)];
//
//    [self.selectedArray addObject:self.csoLabelColl[indexPath.item]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    HP_UserImpressionCell * cell = (HP_UserImpressionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.title.text = self.csoLabelColl[indexPath.item];
    
    [self.selectedArray removeObject:cell.title.text];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        JYEqualCellSpaceFlowLayout *layout = [[JYEqualCellSpaceFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:HPFit(10)];
        // 行间距
        layout.minimumLineSpacing = HPFit(10);
        layout.minimumInteritemSpacing = HPFit(10);
        layout.estimatedItemSize = CGSizeMake(HPFit(20), HPFit(30));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
         [_collectionView registerClass:[HP_UserImpressionCell class] forCellWithReuseIdentifier:@"uimCollectCell"];
        _collectionView.backgroundColor = HPUIColorWithRGB(0xffffff, 1.0);
        _collectionView.allowsMultipleSelection = YES;
    }
    return _collectionView;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = @[].mutableCopy;
    }
    return _selectedArray;
}

@end
