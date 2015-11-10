# YSLDraggableCardContainer

## Demo
#### Dragging Animation
![Dome](https://raw.githubusercontent.com/y-hryk/YSLDraggingCardContainer/master/sample1.gif)
![Dome](https://raw.githubusercontent.com/y-hryk/YSLDraggingCardContainer/master/sample2.gif)
#### Undo Animation
![Dome](https://raw.githubusercontent.com/y-hryk/YSLDraggingCardContainer/master/sample3.gif)
## Requirement
not support landscape

iOS 7.0
## Install
#### Manually
 Copy YSLDraggableCardContainer directory to your project.
#### CocoaPods
 not support
 
## Usage
``` objective-c

#import "YSLDraggableCardContainer.h"

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

    _container = [[YSLDraggableCardContainer alloc]init];
    _container.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight | YSLDraggableDirectionUp;
    [self.view addSubview:_container];
    
    _datas = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"photo_sample_0%d",i + 1],
                               @"name" : @"YSLDraggableCardContainer Demo"};
        [_datas addObject:dict];
    }

    [_container reloadCardContainer];
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
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    NSLog(@"++ Did CompleteAll);
}

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
    NSLog(@"++ Tap card index : %ld",(long)index);
}
```
#### Undo Animation
``` objective-c
- (void)buttonTap:(UIButton *)button
{
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

```

## Licence
MIT
