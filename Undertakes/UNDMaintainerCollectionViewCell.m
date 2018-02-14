//
//  UNDMaintainerCollectionViewCell.m
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDMaintainerCollectionViewCell.h"
#import "UNDStringConstants.h"
#import "masonry.h"

@interface UNDMaintainerCollectionViewCell ()

@property (nonatomic, strong) UIImageView *maintainerImageView;
//@property (nonatomic, strong) UILabel *idLabel;

@end

@implementation UNDMaintainerCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        _idLabel = [UILabel new];
//        _idLabel.textColor = UIColor.grayColor;
        self.backgroundColor = [UIColor grayColor];
//        self.contentView.backgroundColor = [UIColor grayColor];
        self.contentView.backgroundColor = [UIColor grayColor];

        _maintainerImageView = [UIImageView new];
        _maintainerImageView.layer.masksToBounds = YES;
//        _maintainerImageView.layer.cornerRadius = CGRectGetWidth(frame)/2;
        _maintainerImageView.layer.cornerRadius = 10;

        _maintainerImageView.contentMode = UIViewContentModeCenter;
//        [self.contentView addSubview:_idLabel];
        [self.contentView addSubview:_maintainerImageView];
    }
    return self;
}

- (void)setMaintainerImagePath:(NSString *)maintainerImagePath
{
    _maintainerImagePath = maintainerImagePath;
    NSString *filePath = [[UNDStringConstants getDocumentDirPath] stringByAppendingString:maintainerImagePath];
    NSData *dataImg = [NSData dataWithContentsOfFile:filePath];
    [self.maintainerImageView setImage: [UIImage imageWithData:dataImg]];
}

- (void)setVkID:(NSString *)vkID
{
    _vkID = vkID;
//    self.idLabel.text = vkID;
}


- (void)layoutSubviews
{
    [self.maintainerImageView mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.edges.equalTo(self);
     }];
//    [self.idLabel mas_makeConstraints: ^(MASConstraintMaker *make)
//    {
//        make.edges.equalTo(self.contentView);
//    }];
}


#pragma mark - Overriden UICollectionViewCell methods


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.backgroundColor = [UIColor grayColor];
}

@end
