//
//  TestVC07.m
//  Runloop
//


#import "TestVC07.h"
#import "YDPermenantThread.h"

@interface TestVC07 ()
@property (nonatomic,strong)YDPermenantThread  *thread;
@end

@implementation TestVC07

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.thread = [[YDPermenantThread alloc]init];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 60)];
    [self.view addSubview:btn];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"stop" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(stopClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.thread executeTask:^{
         NSLog(@"Do something- %@", [NSThread currentThread]);
    }];
}

-(void)stopClick{
    [self.thread stop];
}

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
@end
