//
//  ViewController.m
//  Runloop
//


#import "ViewController.h"

#import "TestVC01.h"
#import "TestVC02.h"
#import "TestVC03.h"
#import "TestVC04.h"
#import "TestVC05.h"
#import "TestVC06.h"
#import "TestVC07.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  /*
    //获取Runnloop对象
    NSRunLoop *runloop = [NSRunLoop currentRunLoop]; //OC
    CFRunLoopRef runloop2 = CFRunLoopGetCurrent(); //C
    NSLog(@"%p",runloop);
    NSLog(@"%p",runloop2);
    
    //%p 打印出来的地址不一样：因为OC是C的包装
   */
    
    
//    [self creatObserver1];
    
//     [self creatObserver2];
    
//    [self testTimer];
}

-(void)creatObserver2{
    //2. 创建Observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopEntry - 即将进入Loop %@", mode);
                CFRelease(mode);
                break;
            }
            case kCFRunLoopBeforeTimers: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopBeforeTimers - 即将处理 Timer %@", mode);
                CFRelease(mode);
                break;
            }
                
            case kCFRunLoopBeforeSources: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopBeforeSources -即将处理 Source  %@", mode);
                CFRelease(mode);
                break;
            }
                
            case kCFRunLoopBeforeWaiting: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopBeforeWaiting - 即将进入休眠 %@", mode);
                CFRelease(mode);
                break;
            }
                
            case kCFRunLoopAfterWaiting: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopAfterWaiting - 刚从休眠中唤醒 %@", mode);
                CFRelease(mode);
                break;
            }
                
            case kCFRunLoopExit: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopExit - 即将退出Loop %@", mode);
                CFRelease(mode);
                break;
            }
            default:
                break;
        }
    });
    // 添加Observer到RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    // 释放
    CFRelease(observer);

}

-(void)creatObserver1{
    //1. 创建Observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,kCFRunLoopAllActivities, YES, 0, observeRunLoopActicities, NULL);
    // 添加Observer到RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    // 释放
    CFRelease(observer);
}

//监听的方法
void observeRunLoopActicities(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry--即将进入Loop");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers--即将处理 Timer");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources--即将处理 Source");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting-- 即将进入休眠");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting-- 刚从休眠中唤醒");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit--即将退出Loop");
            break;
        default:
            break;
    }
}

-(void)testTimer{
    static int count = 0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%d", ++count);
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//      [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // NSDefaultRunLoopMode、UITrackingRunLoopMode才是真正存在的模式
    // NSRunLoopCommonModes并不是一个真的模式，它只是一个标记
    // timer能在_commonModes数组中存放的模式下工作
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)DemoVC:(id)sender {
//   [self.navigationController pushViewController:[TestVC01 new] animated:YES];
//     [self.navigationController pushViewController:[TestVC02 new] animated:YES];
//    [self.navigationController pushViewController:[TestVC03 new] animated:YES];
//    [self.navigationController pushViewController:[TestVC04 new] animated:YES];
//     [self.navigationController pushViewController:[TestVC05 new] animated:YES];
//     [self.navigationController pushViewController:[TestVC06 new] animated:YES];
    
     [self.navigationController pushViewController:[TestVC07 new] animated:YES];
    
}

@end
