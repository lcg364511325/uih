#import <CoreGraphics/CoreGraphics.h>
#import "AFPickerView.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define ROW_SPACE 39.0
#define CONTENT_OFFSET_Y 20
#define TOOLBAR_HEIGHT 44
#define TOOLBAR_TITLE_WIDTH_OFFSET 80

@interface AFPickerView()
- (UIBarButtonItem *)toolbarTitleItem:(NSString *)title;
- (UIToolbar *)toolbar:(NSString *)title;
- (UIImageView *)backgroundView:(NSString *)imageURL;
- (UIImageView *)shadowView:(NSString *)imageURL;
- (UIImageView *)glassView:(NSString *)imageURL;
- (void)initContentView;
@end

@implementation AFPickerView

@synthesize dataSource, delegate, isHidden, selectedRow, rowFont, rowIndent;

#pragma mark - Custom getters/setters

- (void)setSelectedRow:(int)selectedRow
{
    if (selectedRow >= rowsCount)
        return;

    [contentView setContentOffset:CGPointMake(0.0, ROW_SPACE * selectedRow) animated:NO];
}

- (void)setRowFont:(UIFont *)rowFont
{
    for (UILabel *aLabel in visibleViews)
    {
        aLabel.font = rowFont;
    }

    for (UILabel *aLabel in recycledViews)
    {
        aLabel.font = rowFont;
    }
}

- (void)setRowIndent:(CGFloat)rowIndent
{
    for (UILabel *aLabel in visibleViews)
    {
        CGRect frame = aLabel.frame;
        frame.origin.x = rowIndent;
        frame.size.width = self.frame.size.width - rowIndent;
        aLabel.frame = frame;
    }

    for (UILabel *aLabel in recycledViews)
    {
        CGRect frame = aLabel.frame;
        frame.origin.x = rowIndent;
        frame.size.width = self.frame.size.width - rowIndent;
        aLabel.frame = frame;
    }
}

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame backgroundImage:(NSString *)backgroundImage shadowImage:(NSString *)shadowImage glassImage:(NSString *)glassImage title:(NSString *)title {
    self = [super initWithFrame:frame];
    self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    self.isHidden = YES;
    if (self)
    {
        [self setup];
        [self addSubview:[self toolbar:title]];
        [self addSubview:[self backgroundView:backgroundImage]];
        [self addSubview:[self shadowView:shadowImage]];
        [self addSubview:[self glassView:glassImage]];
        [self initContentView];
        [self addSubview:contentView];
    }
    return self;
}

- (void)setup
{
    rowFont = [UIFont boldSystemFontOfSize:24.0];
    rowIndent = 50.0;
    selectedRow = 0;
    rowsCount = 0;
    visibleViews = [[NSMutableSet alloc] init];
    recycledViews = [[NSMutableSet alloc] init];
}

- (void)reloadData
{
    selectedRow = 0;
    rowsCount = 0;

    for (UIView *aView in visibleViews)
        [aView removeFromSuperview];

    for (UIView *aView in recycledViews)
        [aView removeFromSuperview];

    visibleViews = [[NSMutableSet alloc] init];
    recycledViews = [[NSMutableSet alloc] init];

    rowsCount = [dataSource numberOfRowsInPickerView:self];
    [contentView setContentOffset:CGPointMake(0.0, CONTENT_OFFSET_Y) animated:NO];
    contentView.contentSize = CGSizeMake(contentView.frame.size.width, ROW_SPACE * rowsCount + 3 * ROW_SPACE);
    [self tileViews];
}

- (void)determineCurrentRow
{
    CGFloat delta = contentView.contentOffset.y;
    int position = round(delta / ROW_SPACE);
    selectedRow = position;
    [contentView setContentOffset:CGPointMake(0.0, ROW_SPACE * position + CONTENT_OFFSET_Y) animated:YES];
    [delegate pickerView:self didSelectRow:selectedRow];
}

- (void)didTap:(id)sender
{
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    CGPoint point = [tapRecognizer locationInView:self];
    int steps = floor(point.y / ROW_SPACE) - 2;
    [self makeSteps:steps];
}

- (void)makeSteps:(int)steps
{
    if (steps == 0 || steps > 2 || steps < -2)
        return;

    [contentView setContentOffset:CGPointMake(0.0, ROW_SPACE * selectedRow) animated:NO];

    int newRow = selectedRow + steps;
    if (newRow < 0 || newRow >= rowsCount)
    {
        if (steps == -2)
            [self makeSteps:-1];
        else if (steps == 2)
            [self makeSteps:1];

        return;
    }

    selectedRow = selectedRow + steps;
    [contentView setContentOffset:CGPointMake(0.0, ROW_SPACE * selectedRow) animated:YES];
    [delegate pickerView:self didSelectRow:selectedRow];
}

#pragma mark - recycle queue

- (UIView *)dequeueRecycledView
{
    UIView *aView = [recycledViews anyObject];

    if (aView)
        [recycledViews removeObject:aView];
    return aView;
}

- (BOOL)isDisplayingViewForIndex:(NSUInteger)index
{
    BOOL foundPage = NO;
    for (UIView *aView in visibleViews)
    {
        int viewIndex = aView.frame.origin.y / ROW_SPACE - 2;
        if (viewIndex == index)
        {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}

- (void)tileViews
{
    // Calculate which pages are visible
    CGRect visibleBounds = contentView.bounds;
    int firstNeededViewIndex = floorf(CGRectGetMinY(visibleBounds) / ROW_SPACE) - 2;
    int lastNeededViewIndex  = floorf((CGRectGetMaxY(visibleBounds) / ROW_SPACE)) - 2;
    firstNeededViewIndex = MAX(firstNeededViewIndex, 0);
    lastNeededViewIndex  = MIN(lastNeededViewIndex, rowsCount - 1);

    // Recycle no-longer-visible pages 
    for (UIView *aView in visibleViews)
    {
        int viewIndex = aView.frame.origin.y / ROW_SPACE - 2;
        if (viewIndex < firstNeededViewIndex || viewIndex > lastNeededViewIndex)
        {
            [recycledViews addObject:aView];
            [aView removeFromSuperview];
        }
    }

    [visibleViews minusSet:recycledViews];

    // add missing pages
    for (int index = firstNeededViewIndex; index <= lastNeededViewIndex; index++)
    {
        if (![self isDisplayingViewForIndex:index])
        {
            UILabel *label = (UILabel *)[self dequeueRecycledView];

            if (label == nil)
            {
                label = [[UILabel alloc] initWithFrame:CGRectMake(rowIndent, 0, self.frame.size.width - rowIndent, ROW_SPACE)];
                label.backgroundColor = [UIColor clearColor];
                label.font = self.rowFont;
                label.textColor = RGBACOLOR(0.0, 0.0, 0.0, 0.75);
            }

            [self configureView:label atIndex:index];
            [contentView addSubview:label];
            [visibleViews addObject:label];
        }
    }
}

- (void)configureView:(UIView *)view atIndex:(NSUInteger)index
{
    UILabel *label = (UILabel *)view;
    label.text = [dataSource pickerView:self titleForRow:index];
    CGRect frame = label.frame;
    frame.origin.y = ROW_SPACE * index + 78.0;
    label.frame = frame;
}

#pragma mark - Picker Trigger
- (void)hidePicker {
    if (!isHidden) {
        [UIView animateWithDuration:0.3 animations:^(void) {
            self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }];
        self.isHidden = YES;
    }
}

- (void)showPicker {
    if (isHidden) {
        [UIView animateWithDuration:0.3 animations:^(void) {
            self.frame = CGRectMake(0, self.frame.origin.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }];
        self.isHidden = NO;
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tileViews];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
        [self determineCurrentRow];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self determineCurrentRow];
}

#pragma mark - Private Methods
- (UIBarButtonItem *)toolbarTitleItem:(NSString *)title {
    UILabel *toolbarTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 11.0, self.frame.size.width - TOOLBAR_TITLE_WIDTH_OFFSET, 21.0)];
    toolbarTitleLabel.text = title;
    toolbarTitleLabel.backgroundColor = [UIColor clearColor];
    toolbarTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    toolbarTitleLabel.textColor = RGBACOLOR(255, 255, 255, 1);
    return [[UIBarButtonItem alloc] initWithCustomView:toolbarTitleLabel];
}

- (UIToolbar *)toolbar:(NSString *)title {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, TOOLBAR_HEIGHT)];
    toolbar.tintColor = RGBACOLOR(254, 172, 64, 1);
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:nil action:@selector(hidePicker)];
    UIBarButtonItem *placeHolderButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:[self toolbarTitleItem:title], placeHolderButton, doneButton, nil]];
    return toolbar;
}

- (UIImageView *)backgroundView:(NSString *)imageURL {
    UIImage *bgImage = [UIImage imageNamed:imageURL];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, TOOLBAR_HEIGHT, self.frame.size.width, self.frame.size.height - TOOLBAR_HEIGHT)];
    bgImageView.image = bgImage;
    return bgImageView;
}

- (UIImageView *)shadowView:(NSString *)imageURL {
    UIImage *shadowImage = [UIImage imageNamed:imageURL];
    UIImageView *shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, TOOLBAR_HEIGHT, self.frame.size.width, self.frame.size.height - TOOLBAR_HEIGHT)];
    shadowImageView.image = shadowImage;
    return shadowImageView;
}

- (UIImageView *)glassView:(NSString *)imageURL {
    UIImage *glassImage = [UIImage imageNamed:imageURL];
    UIImageView *glassImageView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 115.0, glassImage.size.width, glassImage.size.height)];
    glassImageView.image = glassImage;
    return glassImageView;
}

- (void)initContentView {
    contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 60, self.frame.size.width, self.frame.size.height - 70)];
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.delegate = self;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [contentView addGestureRecognizer:tapRecognizer];
}

#pragma mark - Override Initializers

- (id)initWithFrame:(CGRect)frame {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-initWithFrame is not a valid initializer for AFPickerView"
                                 userInfo:nil];
}

- (id)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for AFPickerView"
                                 userInfo:nil];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-initWithCoder is not a valid initializer for AFPickerView"
                                 userInfo:nil];
}

@end
