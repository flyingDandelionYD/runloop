//
//  YDPermenantThread.h
//  Runloop
//


#import <Foundation/Foundation.h>

typedef void (^YDPermenantThreadTask)(void);

@interface YDPermenantThread : NSObject
/**
 在当前子线程执行一个任务
 */
- (void)executeTask:(YDPermenantThreadTask)task;

/**
 结束线程
 */
- (void)stop;
@end

