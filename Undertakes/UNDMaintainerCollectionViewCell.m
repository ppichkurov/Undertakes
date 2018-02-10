//
//  UNDMaintainerCollectionViewCell.m
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDMaintainerCollectionViewCell.h"
#import "masonry.h"

@interface UNDMaintainerCollectionViewCell ()

@property (nonatomic, strong) UIImageView *maintainerImageView;

@end

@implementation UNDMaintainerCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor grayColor];
        self.contentView.backgroundColor = [UIColor grayColor];
        _maintainerImageView = [[UIImageView alloc] init];
        _maintainerImageView.layer.masksToBounds = YES;
        _maintainerImageView.layer.cornerRadius = CGRectGetWidth(frame)/2;
        [self.maintainerImageView setImage: [UIImage imageNamed:@"imageTest"]];
        [self.contentView addSubview:_maintainerImageView];
    }
    return self;
}

- (void)setMaintainerImage:(UIImage *)maintainerImage
{
    _maintainerImage = maintainerImage;
    [self.maintainerImageView setImage:maintainerImage];
}


- (void)layoutSubviews
{
    [self.maintainerImageView mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.edges.equalTo(self);
     }];
}


#pragma mark - Overriden UICollectionViewCell methods


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.backgroundColor = [UIColor grayColor];
}

@end
