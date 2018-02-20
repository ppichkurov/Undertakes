//
//  UNDMaintainerCollectionViewCell.m
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDMaintainerCollectionViewCell.h"
#import "UNDTemplatesUI.h"
#import "UNDStringConstants.h"
#import "masonry.h"


@interface UNDMaintainerCollectionViewCell ()


@property (nonatomic, strong) UIImageView *maintainerImageView;

@end

@implementation UNDMaintainerCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
        self.contentView.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
        _maintainerImageView = [UIImageView new];
        _maintainerImageView.layer.masksToBounds = YES;
        _maintainerImageView.layer.cornerRadius = 10;
        _maintainerImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_maintainerImageView];
    }
    return self;
}

- (void)setMaintainerImagePath:(NSString *)maintainerImagePath
{
    if (!maintainerImagePath)
    {
        return;
    }
    _maintainerImagePath = maintainerImagePath;
    NSString *filePath = [[UNDStringConstants getDocumentDirPath] stringByAppendingString:maintainerImagePath];
    NSData *dataImg = [NSData dataWithContentsOfFile:filePath];
    [self.maintainerImageView setImage: [UIImage imageWithData:dataImg]];
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
    self.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
}

@end
