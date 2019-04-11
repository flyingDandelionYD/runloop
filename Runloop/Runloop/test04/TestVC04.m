//
//  TestVC04.m
//  Runloop
//


#import "TestVC04.h"
#import "YDThread4.h"

@interface TestVC04 ()
@property (nonatomic,strong)YDThread4   *thread;
@end

@implementation TestVC04

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //控制器销毁了，但是线程还在  NSRunLoop的run方法是无法停止的，它专门用于开启一个永不销毁的线程（NSRunLoop）
    self.thread = [[YDThread4 alloc] initWithBlock:^{
        NSLog(@"%s %@", __func__, [NSThread currentThread]);
        NSLog(@"%@----begin----", [NSThread currentThread]);
        // 往RunLoop里面添加Source\Timer\Observer (这样RunLoop才有效)
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"%s ----end----", __func__);
    }];
    [self.thread start];
    
    /*
    //这样写：只会执行一次，自动会结束的哟
    self.thread = [[YDThread4 alloc] initWithBlock:^{
        NSLog(@"%@----begin----", [NSThread currentThread]);
            // 往RunLoop里面添加Source\Timer\Observer
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"%@----end----", [NSThread currentThread]);
        }];
    [self.thread start];
   */
    
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
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
