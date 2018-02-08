//
//  UNDPromiseCollectionViewCell.m
//  Undertakes
//
//  Created by Павел Пичкуров on 03.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDPromiseCollectionViewCell.h"

@interface UNDPromiseCollectionViewCell ()

@end

@implementation UNDPromiseCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 20;
    }
    return self;
}

- (UIColor *)colorForImportance:(int64_t)importance
{
    switch ((int)importance) {
        case 1:
            return UIColor.darkGrayColor;
            break;
        case 2:
            return UIColor.grayColor;
            break;
        case 3:
            return UIColor.brownColor;
            break;
        case 4:
            return UIColor.yellowColor;
            break;
        case 5:
            return UIColor.orangeColor;
            break;
        default:
            return UIColor.greenColor;
            break;
    }
}

- (void)setImportance:(int64_t)importance
{
    _importance = importance;
    self.contentView.backgroundColor = [self colorForImportance:importance];
}

#pragma mark - Overriden UICollectionViewCell methods

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.contentView.backgroundColor = [UIColor greenColor];
}

@end
