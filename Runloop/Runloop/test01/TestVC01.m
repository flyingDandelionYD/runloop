//
//  TestVC01.m
//  Runloop
//


#import "TestVC01.h"
#import "YDThread1.h"

@implementation TestVC01

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    YDThread1 *thread = [[YDThread1 alloc]initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
}
-(void)run{
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}

@end
