//
//  ViewController.m
//  test
//
//  Created by chen chen on 2018/1/20.
//  Copyright © 2018年 chen chen. All rights reserved.
//

#import "ViewController.h"
#import "Name.h"

@interface ViewController (){
    NSObject* _instanceObj;
}
@property (nonatomic,copy) void (^blockCC)(void);
@property (nonatomic,strong) Name *name;
- (IBAction)dis:(id)sender;

@end
NSObject* __globalObj = nil;

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UIStoryboard *vv = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewController *v = [vv instantiateInitialViewController];
    [self presentViewController:v animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _instanceObj = [[NSObject alloc] init];
    
    self.name = [[Name alloc] init];
//    __weak typeof(self) weakself = self;//不会循环引用
//    __block ViewController *weakself = self;//会循环引用
//    __weak ViewController *weakself = self;//不会循环引用
    __unsafe_unretained ViewController *weakself = self;//不会循环引用
    self.blockCC = ^{
        [weakself ddd];
    };
    /*
//     __NSGlobalBlock__ 对外部变量没有使用   类似函数 在作用域内一直存在
    float (^sum)(float a,float b)= ^(float a,float b){
        return a+b;
    };
    NSLog(@"global = %@",sum);
    sum(1,3);
    NSLog(@"global1 = %@",sum);
    
    NSArray *testArr = @[@"v",@"v",@"v",@"v"];
    
//     __NSStackBlock__ 作为方法的参数 在函数中使用，对外部变量有使用  在函数结束后就释放
    NSLog(@"block is %@",^{
        NSLog(@"b l =%@",testArr);
    });
    
//    arc 下为__NSMallocBlock__ 因为arc下会默认拷贝到堆上  mrc 下__NSStackBlock__ 需要收到拷贝到堆上
    void (^test)(void) = ^{
        NSLog(@"stack1 = %@",testArr);
    };
    NSLog(@"block1 is %@", test);
    //*/
//    mrc 下
  //  [self test];
    
//    arc 下
    //[self test1];
}

-(void)ddd{
    NSLog(@"dddddddd");
}
/*
- (void) test {
    
    static NSObject* __staticObj = nil;
    
    __globalObj = [[NSObject alloc] init];
    
    __staticObj = [[NSObject alloc] init];
    
    NSObject* localObj = [[NSObject alloc] init];
    
    __block NSObject* blockObj = [[NSObject alloc] init];
    
    typedef void (^MyBlock)(void) ;
    
    MyBlock aBlock = ^{
        //静态变量 内存位置确定  block copy 时直接读取 不增加 引用计数 不进行retain
        NSLog(@"%@", __globalObj);
        
        NSLog(@"%@", __staticObj);
        //全局变量 Block copy时也没有直接retain _instanceObj对象本身，但会retain self
        NSLog(@"%@", _instanceObj);
        //localObj在Block copy时，系统自动retain对象，增加其引用计数。
        NSLog(@"%@", localObj);
       // blockObj在Block copy时也不会retain。
        NSLog(@"%@", blockObj);
        
    };
    NSLog(@"block 0 = %@",aBlock);

    aBlock = [[aBlock copy] autorelease];
    aBlock();
    NSLog(@"block 1 = %@",aBlock);
    
    NSLog(@"%d", [__globalObj retainCount]);
    
    NSLog(@"%d", [__staticObj retainCount]);
    
    NSLog(@"%d", [_instanceObj retainCount]);
    
    NSLog(@"%d", [localObj retainCount]);
    
    NSLog(@"%d", [blockObj retainCount]);
    
}
//*/

///*
- (void) test1 {
    
    static NSObject* __staticObj = nil;
    
    __globalObj = [[NSObject alloc] init];
    
    __staticObj = [[NSObject alloc] init];
    
    NSObject* localObj = [[NSObject alloc] init];
    
    __block NSObject* blockObj = [[NSObject alloc] init];
    
    typedef void (^MyBlock)(void) ;
    
    MyBlock aBlock = ^{
        //静态变量 内存位置确定  block copy 时直接读取 不增加 引用计数 不进行retain
        NSLog(@"%@", __globalObj);
        
        NSLog(@"%@", __staticObj);
        //全局变量 Block copy时也没有直接retain _instanceObj对象本身，但会retain self
        NSLog(@"%@", _instanceObj);
        //localObj在Block copy时，系统自动retain对象，增加其引用计数。
        NSLog(@"%@", localObj);
        // blockObj在Block copy时也不会retain。
        NSLog(@"%@", blockObj);
        
    };
    NSLog(@"block 0 = %@",aBlock);
    
    //aBlock = [aBlock copy];
    __globalObj = nil;
    __staticObj = nil;
    _instanceObj = nil;
    localObj = nil;
    blockObj = nil;
    
    aBlock();
    NSLog(@"block 1 = %@",aBlock);
    
    NSLog(@"%@", __globalObj );
    
    NSLog(@"%@",__staticObj );
    
    NSLog(@"%@", _instanceObj);
    
    NSLog(@"%@", localObj );
    
    NSLog(@"%@", blockObj );
    
}
//*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dis:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
