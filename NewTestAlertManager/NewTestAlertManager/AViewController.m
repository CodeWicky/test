//
//  AViewController.m
//  NewTestAlertManager
//
//  Created by Wicky on 2019/7/12.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"

#import "DDAlertController/DDAlertController.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    DDAlertController * vc = [DDAlertController new];
    UIView * content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    content.backgroundColor = [UIColor whiteColor];
    vc.contentView = content;
    [vc showInViewController:self];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
