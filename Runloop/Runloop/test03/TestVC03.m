//
//  TestVC03.m
//  Runloop
//


#import "TestVC03.h"
#import "YDThread3.h"

@interface TestVC03 ()
@property (nonatomic,strong)YDThread3   *thread;
@end

@implementation TestVC03

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.thread = [[YDThread3 alloc] initWithBlock:^{
        NSLog(@"%s %@", __func__, [NSThread currentThread]);
        NSLog(@"%@----begin----", [NSThread currentThread]);
        // 往RunLoop里面添加Source\Timer\Observer (这样RunLoop才有效)
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"%s ----end----", __func__);
    }];
    [self.thread start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
    NSLog(@"123");
}

-(void)test{
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}

/*
//这样控制器可以被释放了，但是thread没有被释放
-(void)dealloc{
    NSLog(@"%s",__func__);
}
 */


/*
//这样也不会被释放  代码一直会卡在 [[NSRunLoop currentRunLoop] run];这里，任务还没结束，线程就不会死
-(void)dealloc{
    NSLog(@"%s",__func__);
    self.thread = nil ;
}
*/


//这样 写也不对：这样只是在停掉主线程的RunLoop并非该RunLoop
-(void)dealloc{
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s",__func__);
}
@end
