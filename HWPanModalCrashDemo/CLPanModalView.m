//
//  CLPanModalView.m
//  HWPanModalCrashDemo
//
//  Created by long.chen28 on 2022/6/15.
//

#import "CLPanModalView.h"
#import "UIImage+CLAdd.h"

@interface CLPanModalView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mArr;
@end

@implementation CLPanModalView {
    CGFloat _contentHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self configureSubviews];
    }
    return self;
}

- (void)initData {
    _contentHeight = UIScreen.mainScreen.bounds.size.height - 200;
    self.mArr = @[].mutableCopy;
    for (int i = 0 ; i < 20; i++) {
        [self.mArr addObject:[NSString stringWithFormat:@"hello world %d", i]];
    }
}

- (void)configureSubviews {
    
    self.backgroundColor = UIColor.cyanColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake((UIScreen.mainScreen.bounds.size.width - 150) / 2, 5, 150, 50);
    [button setTitle:@"Reload data" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:UIColor.redColor size:CGSizeMake(150, 60)] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, UIScreen.mainScreen.bounds.size.width, _contentHeight - 60)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60; 
    [self addSubview:self.tableView];
}

- (void)buttonClicked:(UIButton *)button {
    [self.mArr removeLastObject];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.mArr[indexPath.row];
    return cell;
}

- (PanModalHeight)longFormHeight {
    return PanModalHeightMake(PanModalHeightTypeContent, _contentHeight);
}

- (PanModalHeight)shortFormHeight {
    return PanModalHeightMake(PanModalHeightTypeContent, 200);
}

- (nullable UIScrollView *)panScrollable {
    return self.tableView;
}

- (void)panModalTransitionWillBegin {
    
}

- (void)didChangeTransitionToState:(PresentationState)state {
    // If we swipe up quickly and then swipe down, the modal won't dismiss as expected because of the state change such as PresentationStateMedium.
    // So we have to reset the state to PresentationStateShort after the state changes each time so that the modal can always swipe down to dismiss.
    if (state != PresentationStateShort) {
        [self hw_panModalTransitionTo:PresentationStateShort];
    }
}

- (BOOL)allowsDragToDismiss {
    return YES;
}

- (BOOL)allowsExtendedPanScrolling {
    return YES;
}

@end
