//
//  HP_ChatViewController.m
//  HuPiao
//
//  Created by a on 2019/6/27.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "HP_ChatViewController.h"
#import "ZXChatBoxController.h"
#import "ZXChatMessageController.h"
#import "ZXMessageModel.h"
#import "HP_UserTool.h"

@interface HP_ChatViewController () <ZXChatMessageControllerDelegate,ZXChatBoxViewControllerDelegate>

@property(nonatomic,strong)ZXChatMessageController * chatMessageVC;
@property(nonatomic,strong)ZXChatBoxController * chatBoxVC;
@property(nonatomic,strong)UIButton * button;
@property(nonatomic,assign) CGFloat viewHeight;

@end

@implementation HP_ChatViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /**
     *  如果状态栏背景为浅色，应选用黑色字样式(UIStatusBarStyleDefault，默认值),如果背景为深色，则选用白色字样式(UIStatusBarStyleLightContent)。
     UIApplication 一个APP只有一个，你在这里可以设置应用级别的设置，就像上面的实例一样，详细见http://www.cnblogs.com/wendingding/p/3766347.html
     */
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageLogStr = @"ChatPage";
    
    self.navigationItem.title = self.navTitle;

    [self setupBase];
}

/**
 * TLChatMessageViewControllerDelegate 的代理方法
 */
#pragma mark - TLChatMessageViewControllerDelegate
- (void) didTapChatMessageView:(ZXChatMessageController *)chatMessageViewController {
    
    [self.chatBoxVC resignFirstResponder];
    
}

/**
 * TLChatBoxViewControllerDelegate 的代理方法
 */
#pragma mark - TLChatBoxViewControllerDelegate
- (void)chatBoxViewController:(ZXChatBoxController *)chatboxViewController sendMessage:(ZXMessageModel *)message {
    // TLMessage 发送的消息数据模型
    message.from = self.user;//[HP_UserTool sharedUserHelper].user;
    /**
     *  这个控制器添加了 chatMessageVC 这个控制器作为子控制器。在这个子控制器上面添加聊天消息的cell
     TLChatBox 的代理 TLChatBoxViewController 实现了它的代理方法
     TLChatBoxViewController 的代理 TLChatViewController 实现代理方法，去在其中的是子控制器更新消息
     */
    [self.chatMessageVC addNewMessage:message];
    
    /**
     *   TLMessage 是一条消息的数据模型。纪录消息的各种属性
     就因为又有下面的这个，所以就有了你发一条，又会多一条的显示效果！！
     */
    /*
    ZXMessageModel *recMessage = [[ZXMessageModel alloc] init];
    recMessage.messageType = message.messageType;
    recMessage.ownerTyper = ZXMessageOwnerTypeOther;
    recMessage.date = [NSDate date];// 当前时间
    recMessage.text = message.text;
    recMessage.imagePath = message.imagePath;
    recMessage.from = message.from;
    [self.chatMessageVC addNewMessage:recMessage];
    */
    /**
     *  滚动插入的消息，使他始终处于一个可以看得见的位置
     */
    [self.chatMessageVC scrollToBottom];
    
}

-(void)chatBoxViewController:(ZXChatBoxController *)chatboxViewController didChangeChatBoxHeight:(CGFloat)height {
    /**
     *   改变BoxController .view 的高度 ，这采取的是重新设置 Frame 值！！
     */
    self.chatMessageVC.view.frameHeight = self.viewHeight - height;
    self.chatBoxVC.view.originY = self.chatMessageVC.view.originY + self.chatMessageVC.view.frameHeight;
    [self.chatMessageVC scrollToBottom];
}

// 进set 方法设置导航名字
#pragma mark - Getter and Setter
-(void)setUser:(MUser *)user {
    _user = user;
    [self.navigationItem setTitle:user.username];
}

/**
 *  两个聊天界面控制器
 */
-(ZXChatMessageController *)chatMessageVC {
    if (_chatMessageVC == nil) {
        _chatMessageVC = [[ZXChatMessageController  alloc] init];
        [_chatMessageVC.view setFrame:CGRectMake(0, k_status_height + k_nav_height, HPScreenW, self.viewHeight - k_bar_height)];// 0  状态 + 导航 宽 viweH - tabbarH
        [_chatMessageVC setDelegate:self];// 代理
    }
    
    return _chatMessageVC;
    
}


-(ZXChatBoxController *) chatBoxVC {
    if (_chatBoxVC == nil) {
        _chatBoxVC = [[ZXChatBoxController alloc] init];
        [_chatBoxVC.view setFrame:CGRectMake(0, HPScreenH - k_bar_height, HPScreenW, HPScreenH)];
        //(origin = (x = 0, y = 618), size = (width = 375, height = 667))  iPhone 6
        [_chatBoxVC setDelegate:self];
    }
    return _chatBoxVC;
}

-(UIButton * )button {
    if (!_button) {
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"返回" forState:UIControlStateNormal];
        _button.titleLabel.font=[UIFont systemFontOfSize:15];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.frame = CGRectMake(0, 0, 60, 30);
        [_button addTarget:self action:@selector(ReturnCick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)ReturnCick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setupBase {
    UIBarButtonItem * barButton= [[UIBarButtonItem alloc]initWithCustomView:self.button];
    self.navigationItem.leftBarButtonItem = barButton;
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    [self setHidesBottomBarWhenPushed:YES];
    
    // 主屏幕的高度减去导航的高度，减去状态栏的高度。在PCH头文件
    self.viewHeight = HPScreenH - k_nav_height - kStatusBarHeight;
    
    [self.view  addSubview:self.chatMessageVC.view];
    [self addChildViewController:self.chatMessageVC];
    
    [self.view  addSubview:self.chatBoxVC.view];
    [self addChildViewController:self.chatBoxVC];
}

@end
