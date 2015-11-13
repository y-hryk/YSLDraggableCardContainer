//
//  YSLDraggableCardContainer.h
//  Crew-iOS
//
//  Created by yamaguchi on 2015/10/22.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSLDraggableCardContainer;

typedef NS_OPTIONS(NSInteger, YSLDraggableDirection) {
    YSLDraggableDirectionDefault     = 0,
    YSLDraggableDirectionLeft        = 1 << 0,
    YSLDraggableDirectionRight       = 1 << 1,
    YSLDraggableDirectionUp          = 1 << 2,
    YSLDraggableDirectionDown        = 1 << 3
};


@protocol YSLDraggableCardContainerDataSource <NSObject>

- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index;
- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index;

@end

@protocol YSLDraggableCardContainerDelegate <NSObject>

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView
    didEndDraggingAtIndex:(NSInteger)index
             draggableView:(UIView *)draggableView
        draggableDirection:(YSLDraggableDirection)draggableDirection;

@optional
- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView
         didSelectAtIndex:(NSInteger)index
             draggableView:(UIView *)draggableView;

- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio;

@end

@interface YSLDraggableCardContainer : UIView

/**
 *  default is YSLDraggableDirectionLeft | YSLDraggableDirectionRight
 */
@property (nonatomic, assign) YSLDraggableDirection canDraggableDirection;
@property (nonatomic, weak) id <YSLDraggableCardContainerDataSource> dataSource;
@property (nonatomic, weak) id <YSLDraggableCardContainerDelegate> delegate;

/**
 *  reloads everything from scratch. redisplays card.
 */
- (void)reloadCardContainer;

- (void)movePositionWithDirection:(YSLDraggableDirection)direction isAutomatic:(BOOL)isAutomatic;
- (void)movePositionWithDirection:(YSLDraggableDirection)direction isAutomatic:(BOOL)isAutomatic undoHandler:(void (^)())undoHandler;

- (UIView *)getCurrentView;


@end
