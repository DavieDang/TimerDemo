//
//  ViewController.m
//  TimerDemo
//
//  Created by admin on 2017/3/10.
//  Copyright © 2017年 com.gz.bingoMobileSchools. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (nonatomic,strong) NSTimer *myTimer;

//设定一个暂停时间
@property (nonatomic,assign) NSInteger endTime;

@end

@implementation ViewController

{
    int seconds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //预设9秒后暂停
    _endTime = 9;
    
    [self.startBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.startBtn setTitle:@"开始" forState:UIControlStateSelected];
    
    [self.startBtn addTarget:self action:@selector(startOrContinue:) forControlEvents:UIControlEventTouchUpInside];

    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(start:) userInfo:nil repeats:YES];
    
    //放在主运行----(主要是解决在界面上进行的其它操作导致计时器停止的问题)
    [[NSRunLoop mainRunLoop] addTimer:self.myTimer forMode:NSDefaultRunLoopMode];
   
}


- (void)startOrContinue:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //暂停
        self.myTimer.fireDate = [NSDate distantFuture];
    }else{
        //开始
        self.myTimer.fireDate = [NSDate distantPast];
    }
    
}


-(void)start:(NSTimer *)timer{
    seconds ++;
    self.timerLabel.text = [NSString stringWithFormat:@"%ds",seconds];
    
    //到达指定时间暂停
    if (seconds == _endTime) {
        self.myTimer.fireDate = [NSDate distantFuture];
         self.startBtn.selected = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    //释放定时器-----（注意：一定要主动释放定时器否则无法移除定时器）！！！！！！！！！！！！
    [self.myTimer invalidate];
}

@end
