//
//  TestVC02.m
//  Runloop
//


#import "TestVC02.h"
#import "YDThread2.h"

@interface TestVC02 ()
@property (nonatomic,strong)YDThread2 *thread;
@end

@implementation TestVC02

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.thread = [[YDThread2 alloc]initWithTarget:self selector:@selector(run) object:nil]; //循环引用啦
    [self.thread start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
//    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:YES]; //YES会崩溃
   //如果CPU在运行当前线程对象的时候线程任务执行完毕\异常强制退出，则当前线程对象进入死亡状态
    NSLog(@"123");
}

-(void)test{
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}

-(void)run{
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
