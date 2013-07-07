//
//  YejhdCell.m
//  uih
//
//  Created by 陈 星 on 13-7-6.
//  Copyright (c) 2013年 才国. All rights reserved.
//

#import "YejhdCell.h"

@implementation YejhdCell

@synthesize lblTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
