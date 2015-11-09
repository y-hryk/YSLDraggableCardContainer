//
//  ViewController.m
//  YSLDraggableCardContainerDemo
//
//  Created by yamaguchi on 2015/11/10.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import "ViewController.h"
#import "YSLDraggableCardContainer.h"
#import "CardView.h"

#define RGB(r, g, b)	 [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]

@interface ViewController () <YSLDraggableCardContainerDelegate, YSLDraggableCardContainerDataSource>

@property (nonatomic, strong) YSLDraggableCardContainer *container;
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
    
    self.view.backgroundColor = RGB(235, 235, 235);
    
    _container = [[YSLDraggableCardContainer alloc]init];
    _container.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight | YSLDraggableDirectionUp;
    [self.view addSubview:_container];
    
    [_container reloadCardContainer];
    
    for (int i = 0; i < 4; i++) {
        
        UIView *view = [[UIView alloc]init];
        CGFloat size = self.view.frame.size.width / 4;
        view.frame = CGRectMake(size * i, self.view.frame.size.height - 150, size, size);
        view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 10, size - 20, size - 20);
        [button setBackgroundColor:RGB(66, 172, 225)];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:40];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = button.frame.size.width / 2;
        button.tag = i;
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        if (i == 0) { [button setTitle:@"U" forState:UIControlStateNormal]; }
        if (i == 1) { [button setTitle:@"D" forState:UIControlStateNormal]; }
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
        [_container movePositionWithDirection:YSLDraggableDirectionUp isAutomatic:YES];
    }
    if (button.tag == 1) {
        __weak ViewController *weakself = self;
        [_container movePositionWithDirection:YSLDraggableDirectionDown isAutomatic:YES resetHandler:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                     message:@"Do you want to reset?"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [weakself.container movePositionWithDirection:YSLDraggableDirectionDown isAutomatic:YES];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [weakself.container movePositionWithDirection:YSLDraggableDirectionDefault isAutomatic:YES];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
        
    }
    if (button.tag == 2) {
        [_container movePositionWithDirection:YSLDraggableDirectionLeft isAutomatic:YES];
    }
    if (button.tag == 3) {
        [_container movePositionWithDirection:YSLDraggableDirectionRight isAutomatic:YES];
    }
}

#pragma mark -- YSLSwipeingViewContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    NSDictionary *dict = _datas[index];
    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(10, 64, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
    view.backgroundColor = [UIColor whiteColor];
    view.imageView.image = [UIImage imageNamed:dict[@"image"]];
    view.label.text = [NSString stringWithFormat:@"%@  %ld",dict[@"name"],(long)index];
    return view;
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return _datas.count;
}

#pragma mark -- YSLSwipeingViewContainer Delegate

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection
{
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
}

- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthDiff:(CGFloat)widthDiff heightDiff:(CGFloat)heightDiff
{
    CardView *view = (CardView *)draggableView;
    
    if (draggableDirection == YSLDraggableDirectionDefault) {
        view.selectedView.alpha = 0;
    }
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
        view.selectedView.backgroundColor = RGB(215, 104, 91);
        view.selectedView.alpha = widthDiff > 0.8 ? 0.8 : widthDiff;
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        view.selectedView.backgroundColor = RGB(114, 209, 142);
        view.selectedView.alpha = widthDiff > 0.8 ? 0.8 : widthDiff;
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        view.selectedView.backgroundColor = RGB(66, 172, 225);
        view.selectedView.alpha = heightDiff > 0.8 ? 0.8 : heightDiff;
    }
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadCardContainer];
    });
}

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
    NSLog(@"++ index : %ld",(long)index);
}

@end
