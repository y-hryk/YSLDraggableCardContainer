//
//  ViewController.m
//  YSLDraggingCardContainerDemo
//
//  Created by yamaguchi on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import "ViewController.h"
#import "YSLDraggingCardContainer.h"
#import "CardView.h"

@interface ViewController () <YSLDraggingCardContainerDelegate, YSLDraggingCardContainerDataSource>

@property (nonatomic, strong) YSLDraggingCardContainer *container;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _container = [[YSLDraggingCardContainer alloc]init];
    _container.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggingDirection = YSLDraggingDirectionLeft | YSLDraggingDirectionRight;
    [self.view addSubview:_container];
    
    [_container reloadContainerView];
    
    for (int i = 0; i < 4; i++) {
        
        UIView *view = [[UIView alloc]init];
        CGFloat size = self.view.frame.size.width / 4;
        view.frame = CGRectMake(size * i, self.view.frame.size.height - 150, size, size);
        view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 10, size - 20, size - 20);
        [button setBackgroundColor:[UIColor colorWithRed:66.0 / 255.0 green:172.0 / 255.0 blue:225.0 / 255.0 alpha:1.0]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:40];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = button.frame.size.width / 2;
        button.tag = i;
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        if (i == 0) { [button setTitle:@"T" forState:UIControlStateNormal]; }
        if (i == 1) { [button setTitle:@"B" forState:UIControlStateNormal]; }
        if (i == 2) { [button setTitle:@"L" forState:UIControlStateNormal]; }
        if (i == 3) { [button setTitle:@"R" forState:UIControlStateNormal]; }
        
    }
    
    [self loadData];
}

- (void)loadData
{
    _datas = [NSMutableArray array];
    
    for (int i = 0; i < 7; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"photo_sample_0%d",i + 1],
                                @"name" : @"YSLDraggingCardContainer Demo"};
        [_datas addObject:dict];
    }
}

#pragma mark -- Selector
- (void)buttonTap:(UIButton *)button
{
    if (button.tag == 0) {
        [_container movePositionWithDirection:YSLDraggingDirectionTop isAutomatic:YES];
    }
    if (button.tag == 1) {
        [_container movePositionWithDirection:YSLDraggingDirectionBottom isAutomatic:YES];
    }
    if (button.tag == 2) {
        [_container movePositionWithDirection:YSLDraggingDirectionLeft isAutomatic:YES];
    }
    if (button.tag == 3) {
        [_container movePositionWithDirection:YSLDraggingDirectionRight isAutomatic:YES];
    }
}

#pragma mark -- YSLSwipeingViewContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    NSDictionary *dict = _datas[index];
    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(10, 64, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
    view.backgroundColor = [UIColor whiteColor];
    view.imageView.image = [UIImage imageNamed:dict[@"image"]];
    view.label.text = dict[@"name"];
    return view;
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return _datas.count;
}

#pragma mark -- YSLSwipeingViewContainer Delegate

- (void)cardContainerView:(YSLDraggingCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggingView:(UIView *)draggingView draggingDirection:(YSLDraggingDirection)draggingDirection
{
    if (draggingDirection == YSLDraggingDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggingDirection isAutomatic:NO];
    }
    
    if (draggingDirection == YSLDraggingDirectionRight) {
        [cardContainerView movePositionWithDirection:YSLDraggingDirectionRight
                                         isAutomatic:NO];
    }
}

- (void)cardContainderView:(YSLDraggingCardContainer *)cardContainderView updatePositionWithDraggingView:(UIView *)draggingView draggingDirection:(YSLDraggingDirection)draggingDirection widthDiff:(CGFloat)widthDiff heightDiff:(CGFloat)heightDiff
{
//    CardView *view = (CardView *)draggingView;
//    // view.selectedView.alpha = 0.0;
//    
//    if (draggingDirection == YSLDraggingDirectionDefault) {
//        view.selectedView.alpha = 0;
//    }
//    
//    if (draggingDirection == YSLDraggingDirectionLeft) {
//        view.selectedView.backgroundColor = RGB(215, 104, 91);
//        view.selectedView.alpha = widthDiff > 0.8 ? 0.8 : widthDiff;
//    }
//    
//    if (draggingDirection == YSLDraggingDirectionRight) {
//        view.selectedView.backgroundColor = RGB(114, 209, 142);
//        view.selectedView.alpha = widthDiff > 0.8 ? 0.8 : widthDiff;
//    }
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggingCardContainer *)container;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadContainerView];
    });
}

- (void)cardContainerView:(YSLDraggingCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggingView:(UIView *)draggingView
{
    NSLog(@"++ index : %ld",(long)index);
}

@end
