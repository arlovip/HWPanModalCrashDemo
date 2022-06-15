//
//  ViewController.m
//  HWPanModalCrashDemo
//
//  Created by long.chen28 on 2022/6/15.
//

#import "ViewController.h"
#import "CLPanModalView.h"
#import "UIImage+CLAdd.h"

@interface ViewController ()
@property (nonatomic, strong) CLPanModalView *panModal;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)configureUI {
    self.view.backgroundColor = UIColor.whiteColor;
    self.panModal = [[CLPanModalView alloc] init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 150, 60);
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageWithColor:UIColor.redColor size:CGSizeMake(150, 60)] forState:UIControlStateNormal];
    [button setTitle:@"Show modal" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)buttonClicked:(UIButton *)button {
    [self.panModal presentInView:self.view];
}

@end
