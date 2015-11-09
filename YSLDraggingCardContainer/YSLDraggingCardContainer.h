//
//  YSLDraggingCardContainer.h
//  Crew-iOS
//
//  Created by yamaguchi on 2015/10/22.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSLDraggingCardContainer;

typedef NS_OPTIONS(NSInteger, YSLDraggingDirection) {
    YSLDraggingDirectionDefault     = 0,
    YSLDraggingDirectionLeft        = 1 << 0,
    YSLDraggingDirectionRight       = 1 << 1,
    YSLDraggingDirectionTop         = 1 << 2,
    YSLDraggingDirectionBottom      = 1 << 3
};


@protocol YSLDraggingCardContainerDataSource <NSObject>

- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index;
- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index;

@end

@protocol YSLDraggingCardContainerDelegate <NSObject>

- (void)cardContainerView:(YSLDraggingCardContainer *)cardContainerView
    didEndDraggingAtIndex:(NSInteger)index
             draggingView:(UIView *)draggingView
        draggingDirection:(YSLDraggingDirection)draggingDirection;

@optional
- (void)cardContainerViewDidCompleteAll:(YSLDraggingCardContainer *)container;

- (void)cardContainerView:(YSLDraggingCardContainer *)cardContainerView
         didSelectAtIndex:(NSInteger)index
             draggingView:(UIView *)draggingView;

- (void)cardContainderView:(YSLDraggingCardContainer *)cardContainderView updatePositionWithDraggingView:(UIView *)draggingView draggingDirection:(YSLDraggingDirection)draggingDirection widthDiff:(CGFloat)widthDiff heightDiff:(CGFloat)heightDiff;

@end

@interface YSLDraggingCardContainer : UIView

/**
 *  Default YSLDraggingDirectionLeft | YSLDraggingDirectionRight
 */
@property (nonatomic, assign) YSLDraggingDirection canDraggingDirection;
@property (nonatomic, weak) id <YSLDraggingCardContainerDataSource> dataSource;
@property (nonatomic, weak) id <YSLDraggingCardContainerDelegate> delegate;


- (void)reloadContainerView;
- (void)movePositionWithDirection:(YSLDraggingDirection)direction isAutomatic:(BOOL)isAutomatic;
- (void)movePositionWithDirection:(YSLDraggingDirection)direction isAutomatic:(BOOL)isAutomatic resetHandler:(void (^)())resetHandler;

- (UIView *)getCurrentView;


@end
