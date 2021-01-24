//
//  ViewController.m
//  FBYWeChatPay
//
//  Created by fby on 2021/1/23.
//

#import "ViewController.h"

#import "WXApi.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *wechatButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH - 20, 45)];
    wechatButton.backgroundColor = [UIColor lightGrayColor];
    [wechatButton addTarget:self action:@selector(wechatButton:) forControlEvents:UIControlEventTouchUpInside];
    [wechatButton setTitle:@"微信支付" forState:0];
    [self.view addSubview:wechatButton];
    
    

}

- (void)wechatButton:(UIButton *)sender {
    // 判断手机有没有微信
    if ([WXApi isWXAppInstalled]) {
        [self WechatPay];
    }else{
        NSLog(@"未安装微信");
    }
}


#pragma mark 微信支付方法
- (void)WechatPay{
    
    //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
//    req.openID = @"";
    // 商家id，在注册的时候给的
    req.partnerId = @"10000100";
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = @"1101000000140415649af9fc314aa427";
    // 根据财付通文档填写的数据和签名
    req.package  = @"Sign=WXPay";
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = @"a462b76e7436e98e0ed6e13c64b4fd1c";
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = @"1397527777";
    req.timeStamp = stamp.intValue;
    // 这个签名也是后台做的
    req.sign = @"582282D72DD2B03AD892830965F428CB16E7A256";
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
    
}
@end
