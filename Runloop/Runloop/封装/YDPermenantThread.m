//
//  YDPermenantThread.m
//  Runloop
//


#import "YDPermenantThread.h"

@interface YDThread : NSThread
@end

@implementation YDThread
-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
@end



@interface YDPermenantThread()
@property (nonatomic,strong)YDThread  *myThread;
@property (assign, nonatomic, getter=isStopped) BOOL stopped;
@end

@implementation YDPermenantThread
-(instancetype)init{
    if(self = [super init]){
        self.stopped = NO;
        __weak typeof(self) weakSelf = self;
        self.myThread = [[YDThread alloc]initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc]init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.isStopped) {
                 [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
        [self.myThread start];
    }return self;
}


- (void)executeTask:(YDPermenantThreadTask)task{
    if(!self.myThread || !task)return;
    [self performSelector:@selector(__executeTask:) onThread:self.myThread withObject:task waitUntilDone:NO];
}


- (void)stop{
    if (!self.myThread) return;
    [self performSelector:@selector(__stop) onThread:self.myThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc{
    NSLog(@"%s", __func__);
    [self stop];
}

#pragma mark - private methods
- (void)__stop{
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.myThread = nil;
}

- (void)__executeTask:(YDPermenantThreadTask)task{
    task();
}
@end
