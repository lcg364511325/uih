//
//  YGPSegmentedController.h
//  YGPSegmentedSwitch
//
//  Created by yang on 13-6-27.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGPSegmentedController;
@protocol YGPSegmentedControllerDelegate <NSObject>
@optional
- (void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index;

@end



@interface YGPSegmentedController : UIView

{
     
     UIImageView *ButtonbackgroundImage;    //选中时背景视图
     NSInteger    SelectedTagChang;              //选择tag

}
@property (assign, nonatomic) id<YGPSegmentedControllerDelegate>Delegate;

@property (strong, nonatomic) NSMutableArray  * TitleArray;             //按钮title
@property (retain, nonatomic) UIButton        * SegmentedButton;        //button
@property (retain, nonatomic) UIScrollView    * YGPScrollView;         //滚动视图


/*
 初始化方法
 title 传入button的title（NSArray）
 Frame 设置view的框架
 */
-(id)initContentTitle:(NSArray*)Title buttonwidth:(int) width CGRect:(CGRect)Frame;

//初始化选择indx （0）
/*由于技术原因在初始选择时请调用次方法
 此方法初始值为0*/
-(NSInteger)initselectedSegmentIndex;

//设置背景颜色
-(void)setBackgroundColor;

@end
