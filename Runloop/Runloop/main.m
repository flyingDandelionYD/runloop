//
//  main.m
//  Runloop
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//有runloop
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

////没有runloop
//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        NSLog(@"Hello world");
//    }
//}
////执行完后会退出程序


////伪代码
//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        int retVal = 0;
//        do{
//            //睡眠中等待消息
//            int message = sleep_and_wait();
//            //处理消息
//            retVal = process_message(message);
//        }while (retVal == 0);
//        return 0;
//    }
//}





