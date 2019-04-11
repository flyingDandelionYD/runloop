//
//  TestVC06.m
//  Runloop
//


#import "TestVC06.h"
#import "YDThread6.h"


@interface TestVC06 ()
@property (nonatomic,strong)YDThread6 *thread;
@property (assign, nonatomic, getter=isStoped) BOOL stopped;
@end

@implementation TestVC06

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    self.stopped = NO;
    self.thread = [[YDThread6 alloc] initWithBlock:^{
        NSLog(@"%@----begin----", [NSThread currentThread]);
        while (weakSelf && !weakSelf.isStoped) {
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
    if (!self.thread) return;
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void)test{
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}

-(void)stopClick{
    if (!self.thread) return;
    //在子线程调用stop（waitUntilDone设置为YES，代表子线程的代码执行完毕后，这个方法才会往下走）
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

-(void)stopThread{
    // 设置标记为NO
    self.stopped = YES;
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
    // 清空线程
    self.thread = nil;
}

-(void)dealloc{
    NSLog(@"%s",__func__);
    [self stopClick];
}
@end
