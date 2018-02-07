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
        self.backgroundColor = [UIColor whiteColor];
        _maintainerImageView = [[UIImageView alloc] init];
        
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
    self.contentView.layer.cornerRadius = 20;
}


#pragma mark - Overriden UICollectionViewCell methods


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.backgroundColor = [UIColor whiteColor];
}

@end
