//
//  HZFindCardViewController.m
//  ToFindCardStreamDemo
//
//  Created by 鄂鸿桢 on 16/9/1.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "HZFindCardViewController.h"
#import "HZFindCardTableViewCell.h"
#import "UIView+Extension.h"

#define HZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]


@interface HZFindCardViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UIScrollViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerImageView;
@end

@implementation HZFindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"TO FIND";
    [self setupBaseView];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;

    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.headerImageView.transform = CGAffineTransformMakeScale(0.8, 0.8);

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 250;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    CGRect headerFrame = CGRectMake(28, 44, tableView.width - 56, 240);
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:headerFrame];
    headerImageView.image = [UIImage imageNamed:@"IMG_2615"];
    [headerView addSubview:headerImageView];
    self.headerImageView = headerImageView;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZFindCardTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HZFindCardTableViewCell"
                                                           owner:self
                                                         options:nil] firstObject];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellView.backgroundColor = HZRandomColor;
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"%f", velocity.y);
    if (velocity.y > 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:0.5 animations:^{
            CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -114);
            CGAffineTransform scale = CGAffineTransformMakeScale(1.4, 1);
            self.headerImageView.transform = CGAffineTransformConcat(translation, scale);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [UIView animateWithDuration:0.5 animations:^{
            self.headerImageView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

//- scrolldrag

#pragma mark - 私有方法
- (void)setupBaseView {
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back"]forState:UIControlStateNormal];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [closeButton setImage:[UIImage imageNamed:@"nav_close_icon@3x"]forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"IMG_1935"];
    [self.view addSubview:backgroundImageView];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self useMethodToFindBlackLineAndHind];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)useMethodToFindBlackLineAndHind {
    UIImageView *blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    blackLineImageView.hidden = YES;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
