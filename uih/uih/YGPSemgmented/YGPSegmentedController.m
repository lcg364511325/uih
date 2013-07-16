//
//  YGPSegmentedController.m
//  YGPSegmentedSwitch
//
//  Created by yang on 13-6-27.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import "YGPSegmentedController.h"
#import "Globle.h"

//按钮空隙
#define BUTTONGAP 0
//按钮长度
#define BUTTONWIDTH 95
//按钮宽度
#define BUTTONHEIGHT 40
//滑条CONTENTSIZEX
#define CONTENTSIZEX 320
//选择显示区域（view）
#define SelectVisible (sender.tag-100)
#define initselectedIndex 0

@implementation YGPSegmentedController

@synthesize TitleArray;
@synthesize SegmentedButton;
@synthesize Delegate=_delegate;
static int widthbutton=50;

@synthesize YGPScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         
         self.frame =CGRectZero;
         YGPScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
         SelectedTagChang = 1;
       
         [self SetScrollview];     //setup
         [self setSelectedIndex:0];
         
    }
    return self;
}

//初始化框架数据
-(id)initContentTitle:(NSMutableArray*)Title buttonwidth:(int) width CGRect:(CGRect)Frame
{
     if (self = [super init])
     {
          widthbutton=width;
          [self addSubview:YGPScrollView];
          TitleArray = Title ;
          [self setFrame:Frame];
          [YGPScrollView setFrame:Frame];
          [self setBackgroundColor];
          YGPScrollView.contentSize = CGSizeMake((widthbutton+BUTTONGAP)*[self.TitleArray count]+BUTTONGAP, 40);
          
     }
     
     //初始化button
     [self initWithButton];
     return self;
}

//设置滚动视图
-(void)SetScrollview
{

    YGPScrollView.backgroundColor = [Globle colorFromHexRGB:@"C2E0BA"];//[UIColor whiteColor];
     YGPScrollView.pagingEnabled = NO;
     YGPScrollView.scrollEnabled=YES;
     YGPScrollView.showsHorizontalScrollIndicator = NO;
     YGPScrollView.showsVerticalScrollIndicator = NO;
}

//初始化button
-(void)initWithButton
{
     //设置选中背景
     //ButtonbackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, widthbutton, 40)];
     //[ButtonbackgroundImage setImage:[UIImage imageNamed:@"red_background.png"]];
     //[YGPScrollView addSubview:ButtonbackgroundImage];
     
     for (int i = 0; i<[self.TitleArray count]; i++)
     {
          SegmentedButton = [UIButton buttonWithType:UIButtonTypeCustom];
          [SegmentedButton setFrame:CGRectMake(BUTTONGAP+(BUTTONGAP+widthbutton)*i, 0, widthbutton, 40)];
          SegmentedButton.tag=i+100;
          
          if (i==0)
          {
               SegmentedButton.selected=NO;
          }
          
          [SegmentedButton setTitle:[NSString stringWithFormat:@"%@",[self.TitleArray objectAtIndex:i]] forState:UIControlStateNormal];
          SegmentedButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
          SegmentedButton.titleLabel.textColor = [Globle colorFromHexRGB:@"000000"];
         
          //if (SegmentedButton.titleLabel.text.length==4) {
          //     SegmentedButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
           
          //     [SegmentedButton setFrame:CGRectMake(BUTTONGAP+(BUTTONGAP+widthbutton)*i-5, 0, widthbutton+18, 40)];
          //}

          //[SegmentedButton setTitleColor:[Globle colorFromHexRGB:@"868686"] forState:UIControlStateNormal];
          //[SegmentedButton setTitleColor:[Globle colorFromHexRGB:@"bb0b15"] forState:UIControlStateSelected];
          [SegmentedButton addTarget:self action:@selector(SelectButton:) forControlEvents:UIControlEventTouchUpInside];
          [SegmentedButton setBackgroundImage:[UIImage imageNamed:@"greenbg"] forState:UIControlStateNormal];
          [SegmentedButton setBackgroundImage:[UIImage imageNamed:@"greenclick"] forState:UIControlStateSelected];
       
          [YGPScrollView addSubview:SegmentedButton];
     }
}

//点击button调用方法
-(void)SelectButton:(UIButton*)sender
{
     
     //取消当前选择
     if (sender.tag!=SelectedTagChang) {
          UIButton * ALLButton = (UIButton*)[self viewWithTag:SelectedTagChang];
          ALLButton.selected=NO;
          SelectedTagChang = sender.tag;
     }
     
     
     sender.selected=YES;
     
     [UIView animateWithDuration:0.25 animations:^{
          [ButtonbackgroundImage setFrame:CGRectMake(sender.frame.origin.x, 0, widthbutton, 40)];
     } completion:^(BOOL finished){
           [self setSelectedIndex:SelectVisible];
      
       }];
}

//选择index
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
     
     if ([_delegate respondsToSelector:@selector(segmentedViewController:touchedAtIndex:)])
          [_delegate segmentedViewController:self touchedAtIndex:selectedIndex];

}

-(NSInteger)initselectedSegmentIndex
{

     //初始化为（0）
     return initselectedIndex;

}

-(void)setBackgroundColor
{
     //为了区别Tab和View的颜色
     //self.backgroundColor = [UIColor grayColor];
     //YGPScrollView.alpha = 0.9;

}
@end
