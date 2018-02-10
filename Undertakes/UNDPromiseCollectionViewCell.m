//
//  UNDPromiseCollectionViewCell.m
//  Undertakes
//
//  Created by Павел Пичкуров on 03.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDPromiseCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface UNDPromiseCollectionViewCell ()

@property (nonatomic, strong) UIView *substrateView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *fullTextLabel;

@end

@implementation UNDPromiseCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor grayColor];
        _substrateView = [UIView new];
        _substrateView.alpha = 0.8;
        self.contentView.alpha = 0.8;
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _fullTextLabel = [UILabel new];
        _fullTextLabel.textAlignment = NSTextAlignmentCenter;
        _fullTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _fullTextLabel.numberOfLines = 5;
        [_substrateView addSubview:_titleLabel];
        [_substrateView addSubview:_fullTextLabel];
        _substrateView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:_substrateView];
        self.contentView.layer.cornerRadius = 20;
        _substrateView.layer.cornerRadius = 20;
    }
    return self;
}

- (void)layoutSubviews
{
    UIEdgeInsets padding = UIEdgeInsetsMake(2, 25, 3, 3);
    [self.substrateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).with.offset(padding.left);
        make.trailing.equalTo(self.contentView).with.offset(-padding.right);
        make.top.equalTo(self.contentView).with.offset(padding.top);
        make.bottom.equalTo(self.contentView).with.offset(-padding.bottom);
    }];
    
    UIEdgeInsets paddingLabels = UIEdgeInsetsMake(20, 20, 150, 20);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.substrateView).with.insets(paddingLabels);
    }];
    
    UIEdgeInsets paddingFullText = UIEdgeInsetsMake(40, 10, 10, 10);
    
    [self.fullTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.substrateView).with.offset(paddingFullText.left);
        make.trailing.equalTo(self.substrateView).with.offset(-paddingFullText.right);
        make.top.equalTo(self.titleLabel).with.offset(paddingFullText.top);
//        make.bottom.equalTo(self.substrateView).with.offset(-paddingFullText.bottom).priorityLow();
    }];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    _title = title;
}

- (void)setFullText:(NSString *)fullText
{
    self.fullTextLabel.text = fullText;
    _fullText = fullText;
}

- (UIColor *)colorForImportance:(int64_t)importance
{
    switch ((int)importance) {
        case 1:
            return UIColor.darkGrayColor;
            break;
        case 2:
            return [UIColor colorWithRed:0
                                   green:153/255.0f
                                    blue:153/255.0f
                                   alpha:1];
            break;
        case 3:
            return UIColor.brownColor;
            break;
        case 4:
            return UIColor.purpleColor;
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
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.substrateView.backgroundColor = [UIColor whiteColor];
    self.title = @"";
    self.fullText = @"";
}

@end
