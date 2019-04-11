//
//  TestVC04.m
//  Runloop
//


#import "TestVC05.h"
#import "YDThread5.h"

@interface TestVC05 ()
@property (nonatomic,strong)YDThread5   *thread;
@property (assign, nonatomic, getter=isStoped) BOOL stopped;
@end

@implementation TestVC05

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    self.stopped = NO;
    self.thread = [[YDThread5 alloc] initWithBlock:^{
        NSLog(@"%s %@", __func__, [NSThread currentThread]);
        NSLog(@"%@----begin----", [NSThread currentThread]);
        while (!weakSelf.isStoped) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        NSLog(@"%s ----end----", __func__);
     }];
    [self.thread start];

    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 60)];
    [self.view addSubview:btn];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"stop" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(stopClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
    NSLog(@"123");
}

-(void)test{
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}

- (void)stopClick{
    [self performSelector:@selector(stop1) onThread:self.thread withObject:nil waitUntilDone:NO];
}

// 用于停止子线程的RunLoop
-(void)stop1{
    // 设置标记为NO
    self.stopped = YES;
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
    
    //这样：主动点击stop，线程会跟随控制器而销毁，
    
    //但是如果直接点击返回，会崩溃，
    // [self performSelector:@selector(stop1) onThread:self.thread withObject:nil waitUntilDone:NO];
    //这样并未等子线程执行完 就执行了 "}"了，之后执行dealloc方法，控制器为nil，所以会出现坏内存访问 （vc没了）

}

-(void)dealloc{
    NSLog(@"%s",__func__);
    [self stopClick];
}


@end

