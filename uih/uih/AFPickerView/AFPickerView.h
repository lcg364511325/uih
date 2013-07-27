#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@protocol AFPickerViewDataSource;
@protocol AFPickerViewDelegate;

@interface AFPickerView : UIView <UIScrollViewDelegate> {
    __unsafe_unretained id <AFPickerViewDataSource> dataSource;
    __unsafe_unretained id <AFPickerViewDelegate> delegate;
    UIScrollView *contentView;

    int rowsCount;

    CGPoint previousOffset;
    BOOL isScrollingUp;

    // recycling
    NSMutableSet *recycledViews;
    NSMutableSet *visibleViews;

}

@property(nonatomic, unsafe_unretained) id <AFPickerViewDataSource> dataSource;
@property(nonatomic, unsafe_unretained) id <AFPickerViewDelegate> delegate;
@property(nonatomic, unsafe_unretained) int selectedRow;
@property(nonatomic, strong) UIFont *rowFont;
@property(nonatomic, unsafe_unretained) CGFloat rowIndent;
@property(nonatomic, unsafe_unretained) BOOL isHidden;

- (id)initWithFrame:(CGRect)frame backgroundImage:(NSString *)backgroundImage shadowImage:(NSString *)shadowImage glassImage:(NSString *)glassImage title:(NSString *)title;

- (void)setup;

- (void)reloadData;

- (void)determineCurrentRow;

- (void)didTap:(id)sender;

- (void)makeSteps:(int)steps;

// recycle queue
- (UIView *)dequeueRecycledView;

- (BOOL)isDisplayingViewForIndex:(NSUInteger)index;

- (void)tileViews;

- (void)configureView:(UIView *)view atIndex:(NSUInteger)index;

- (void)hidePicker;

- (void)showPicker;

@end


@protocol AFPickerViewDataSource <NSObject>

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView;

- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row;

@end


@protocol AFPickerViewDelegate <NSObject>

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row;

@end