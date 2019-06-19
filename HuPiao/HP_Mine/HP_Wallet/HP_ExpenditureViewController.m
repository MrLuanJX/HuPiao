//
//  HP_ ExpenditureViewController.m
//  HuPiao
//
//  Created by a on 2019/6/10.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_ExpenditureViewController.h"

@interface HP_ExpenditureViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) FFDropDownMenuView * dropDownMenu;
@end

@implementation HP_ExpenditureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTableView];
    
    [self setupRightNav];
}

- (void) setupRightNav {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(screenAction) Title:@"筛选" TitleColor:[UIColor blackColor]];
}

- (void) screenAction {
    NSLog(@"筛选");
    [self createDropdownMenuMethodOne];
}

- (void) addTableView {
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.mas_equalTo (0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HPFit(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;

    cell.textLabel.text = [NSString stringWithFormat:@"测试数据---%ld",indexPath.row];
   
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    }
    return _tableView;
}

/** 获取下拉菜单模型数组 */
- (NSArray *)getDropDownMenuModelsArray {
    __weak typeof(self)weakSelf = self;
    //菜单模型0
    
    NSMutableArray * titleArray = self.isIncome == YES ? [NSMutableArray arrayWithObjects:@"充值",@"礼物",@"购买", nil] : [NSMutableArray arrayWithObjects:@"提现",@"礼物",@"购买", nil];
    NSMutableArray * dropMenuArr = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:titleArray[i] menuItemIconName:@"menu0" menuBlock:^{
            NSLog(@"点击了第%d个title",i);
//            UIViewController *vc = [UIViewController new];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        [dropMenuArr addObject:menuModel0];
    }

    NSMutableArray * menuModelArr = [NSMutableArray array];
    [menuModelArr addObjectsFromArray:dropMenuArr];
    return menuModelArr;
}

/** 创建下拉菜单方式1 */
- (void)createDropdownMenuMethodOne {
    //若使用默认CGFloat值     请使用 FFDefaultFloat
    //若使用默认CGSize值      请使用 FFDefaultSize
    //若使用默认Cell值        请使用 FFDefaultCell
    //若使用默认Color值       请使用 FFDefaultColor
    //若使用默认ScaleType值   请使用 FFDefaultMenuScaleType
    NSArray *menuModelsArr = [self getDropDownMenuModelsArray];
    self.dropDownMenu = [FFDropDownMenuView ff_DefaultStyleDropDownMenuWithMenuModelsArray:menuModelsArr menuWidth:145 eachItemHeight:40 menuRightMargin:10 triangleRightMargin:20];
    self.dropDownMenu.triangleY = k_top_height;
    [self.dropDownMenu setup];
    [self.dropDownMenu showMenu];
    //若还需要对别的属性进行赋值，则可以再对别的属性进行赋值，最后一定要调用setup方法。如下
    /*
     self.dropDownMenu.menuScaleType = FFDropDownMenuViewScaleType_TopRight;
     self.dropDownMenu...... = ......;
     [self.dropDownMenu setup];
     */
}

@end
