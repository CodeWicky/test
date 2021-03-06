//
//  ViewController.m
//  TestAlertManager
//
//  Created by Wicky on 2019/6/21.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "ViewController.h"
#import "AViewController.h"

#import "DWTransition.h"

#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    UIView * red = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    red.backgroundColor = [UIColor redColor];
    [self.view addSubview:red];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AViewController * new = [AViewController new];
    new.pushAnimationType = DWTransitionTransparentPushType;
    [self.navigationController pushViewController:new animated:YES];
}


@end
