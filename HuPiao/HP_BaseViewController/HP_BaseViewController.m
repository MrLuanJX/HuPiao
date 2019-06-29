//
//  HP_BaseViewController.m
//  HuPiao
//
//  Created by 栾金鑫 on 2019/5/19.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "HP_BaseViewController.h"

@interface HP_BaseViewController ()

@end

@implementation HP_BaseViewController

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"pageLogStr --- %@",self.pageLogStr);
    [JANALYTICSService startLogPageView:self.pageLogStr];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"DispageLogStr --- %@",self.pageLogStr);
    [JANALYTICSService stopLogPageView:self.pageLogStr];    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
