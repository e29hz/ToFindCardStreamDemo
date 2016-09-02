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
#import "HZCellAlertView.h"

#define HZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]


@interface HZFindCardViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UIScrollViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *maskButton;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) HZCellAlertView *cellAlertView;
@property (nonatomic, assign) CGPoint cellPoint;

@property (nonatomic, assign) CGFloat lastOffsetY;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation HZFindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"TO FIND";
    self.imageArray = @[@"IMG_2612", @"IMG_2615", @"IMG_2618", @"IMG_2619", @"IMG_2622"];
    [self setupBaseView];
    [self setupTableView];
    [self setupAlertView];
}

#pragma mark - setup

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

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)setupAlertView {
    UIButton *maskButton = [[UIButton alloc] initWithFrame:self.view.bounds];
    maskButton.backgroundColor = [UIColor lightGrayColor];
    maskButton.hidden = YES;
    [maskButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:maskButton];
    self.maskButton = maskButton;
    
    HZCellAlertView *cellAlertView = [[[NSBundle mainBundle] loadNibNamed:@"HZCellAlertView"
                                                                    owner:self
                                                                  options:nil] firstObject];
    cellAlertView.frame = CGRectMake(0, 0, self.view.width - 40, 400);
    cellAlertView.layer.cornerRadius = 10;
    cellAlertView.layer.masksToBounds = YES;
    cellAlertView.hidden = YES;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    [button setImage:[UIImage imageNamed:@"nav_close_icon@3x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [cellAlertView addSubview:button];
    [self.view addSubview:cellAlertView];
    self.cellAlertView = cellAlertView;
}
#pragma mark - action
- (void)close {
    [UIView animateWithDuration:0.5 animations:^{
        self.maskButton.alpha = 0;
        self.cellAlertView.transform = CGAffineTransformMakeScale(0.88, 0.3);
        self.cellAlertView.center = self.cellPoint;
        self.cellAlertView.alpha = 0;
        NSLog(@"%f", self.cellPoint.y);
    } completion:^(BOOL finished) {
        self.maskButton.hidden = YES;
        self.cellAlertView.hidden = YES;
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    CGRect headerFrame = CGRectMake(28, 54, tableView.width - 56, 130);
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:headerFrame];
    headerImageView.image = [UIImage imageNamed:@"big_money"];
    headerImageView.layer.cornerRadius = 10;
    headerImageView.layer.masksToBounds = YES;
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
    cell.coverImageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.cellView.backgroundColor = HZRandomColor;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HZFindCardTableViewCell *cell = (HZFindCardTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.maskButton.hidden = NO;
    self.maskButton.alpha = 0;
    self.cellAlertView.hidden = NO;
    self.cellAlertView.alpha = 0;
    CGPoint point = CGPointMake(cell.center.x, cell.center.y - tableView.contentOffset.y);
    self.cellAlertView.center = point;
    self.cellAlertView.transform = CGAffineTransformMakeScale(0.88, 0.3);
    self.cellAlertView.cellView.alpha = 0;
    self.cellAlertView.cellView.transform = CGAffineTransformMakeScale(0.88, 0.3);
    self.cellPoint = point;
    [UIView animateWithDuration:0.5 animations:^{
        self.maskButton.alpha = 0.5;
        self.cellAlertView.alpha = 1;
        self.cellAlertView.transform = CGAffineTransformMakeScale(1, 1);
        self.cellAlertView.center = self.view.center;
    }];
    [UIView animateWithDuration:0.3
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.cellAlertView.cellView.alpha = 1;
        self.cellAlertView.cellView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.y > 0) {
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -44);
        CGAffineTransform scale = CGAffineTransformMakeScale(1.2, 1.2);
        self.headerImageView.transform = CGAffineTransformConcat(translation, scale);
        self.navigationController.navigationBar.transform = CGAffineTransformConcat(translation, scale);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f", offsetY);
    CGFloat change = offsetY - self.lastOffsetY;
    CGFloat headerImageMaxY = CGRectGetMaxY(self.headerImageView.frame);
        if (offsetY < headerImageMaxY && offsetY >= 0) {
            if (change > 0) {
                [self headerViewWithProgress:offsetY / headerImageMaxY];
            } else {

                [self headerViewWithProgress:offsetY / headerImageMaxY];
            }
        }
    if (offsetY > 200) {
        [self headerViewWithProgress:1];
    }
    self.lastOffsetY = offsetY;
    
}

#pragma mark - 私有方法

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

- (void)headerViewWithProgress:(CGFloat)progress {
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -44 * progress);
    CGAffineTransform scale = CGAffineTransformMakeScale(1 + (0.2 * progress), 1 + (progress * 0.2));
    self.headerImageView.transform = CGAffineTransformConcat(translation, scale);
    self.navigationController.navigationBar.transform = CGAffineTransformConcat(translation, scale);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
