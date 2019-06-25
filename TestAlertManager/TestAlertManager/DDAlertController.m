//
//  DWAlertController.m
//  TestAlertManager
//
//  Created by Wicky on 2019/6/22.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "DDAlertController.h"

@interface DDAlertController ()

@property (nonatomic ,strong) UIView * bgContainer;

@property (nonatomic ,strong) UIImageView * snapNavigationBar;

@property (nonatomic ,assign) BOOL sourceHiddenNavigation;

@property (nonatomic ,strong) UIViewController * currentVC;

@end

@implementation DDAlertController
@synthesize pushAnimationType = _pushAnimationType;
@synthesize popAnimationType = _popAnimationType;
@synthesize animationFlag = _animationFlag;

#pragma mark --- interface method ---
-(void)show {
    [self showInViewController:self.currentVC];
}

-(void)showInViewController:(UIViewController *)vc {
    if (vc.navigationController) {
        self.currentVC = vc;
        [vc.navigationController pushViewController:self animated:YES];
    }
}

-(void)configWithCurrentViewController:(UIViewController *)currentVC {
    if (currentVC.navigationController) {
        self.currentVC = currentVC;
    } else if ([currentVC isKindOfClass:[UINavigationController class]]) {
        self.currentVC = ((UINavigationController *)currentVC).topViewController;
    }
}

-(void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- tool method ---
-(void)setupUI {
    [self.view addSubview:self.bgContainer];
    if (!self.sourceHiddenNavigation) {
        UINavigationBar * bar = self.navigationController.navigationBar;
        CGRect frame = bar.frame;
        frame.size.height = CGRectGetMaxY(frame);
        frame.origin.y = 0;
        ///分割线高度
        frame.size.height += 0.5;
        UIImage * image = [self snapWithView:self.navigationController.view];
        image = [self cropWithImage:image inRect:frame];
        self.snapNavigationBar.image = image;
        [self.view addSubview:self.snapNavigationBar];
        self.snapNavigationBar.frame = frame;
    }
}

-(UIImage *)snapWithView:(UIView *)view {
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *)cropWithImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = image.scale;
    
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(scale, scale));
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}

#pragma mark --- life cycle ---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceHiddenNavigation = self.navigationController.navigationBarHidden;
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.currentVC.navigationController setNavigationBarHidden:self.sourceHiddenNavigation];
}

#pragma mark --- override ---
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!CGRectEqualToRect(self.bgContainer.frame, self.view.bounds)) {
        self.bgContainer.frame = self.view.bounds;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.cancelableOnClickBackground && [self.navigationController.topViewController isEqual:self]) {
        CGPoint pointInContent = [[touches anyObject] locationInView:self.contentView];
        if (CGRectContainsPoint(self.contentView.frame, pointInContent)) {
            return;
        }
        [self dismiss];
    }
}

-(instancetype)init {
    if (self = [super init]) {
        _cancelableOnClickBackground = YES;
    }
    return self;
}

-(void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark --- setter/getter ---
-(UIView *)bgContainer {
    if (!_bgContainer) {
        _bgContainer = [[UIView alloc] init];
    }
    return _bgContainer;
}

-(UIImageView *)snapNavigationBar {
    if (!_snapNavigationBar) {
        _snapNavigationBar = [[UIImageView alloc] init];
    }
    return _snapNavigationBar;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor {
    self.bgContainer.backgroundColor = backgroundColor;
}

-(UIColor *)backgroundColor {
    return self.bgContainer.backgroundColor;
}

-(DWTransitionType)pushAnimationType {
    return DWTransitionTransparentPushType | DWTransitionAnimationNoneType;
}

-(DWTransitionType)popAnimationType {
    return DWTransitionTransparentPopType | DWTransitionAnimationNoneType;
}

@end
