//
//  UNDAlreadyDoneTableViewCell.m
//  Undertakes
//
//  Created by Павел Пичкуров on 20.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDAlreadyDoneTableViewCell.h"
#import "UNDTemplatesUI.h"
#import "masonry.h"

@interface UNDAlreadyDoneTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *fullTextView;
@property (nonatomic, strong) UIView *importanceView;


@end

@implementation UNDAlreadyDoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundView.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
        self.contentView.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
        
        [self prepareTitleLabel];
        [self prepareFullTextView];
        [self prepareImportanceView];
    }
    return self;
}

- (void)prepareTitleLabel
{
    _titleLabel = [UILabel new];
    _titleLabel.textColor = UIColor.blackColor;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
}

- (void)prepareFullTextView
{
    _fullTextView = [UITextView new];
    _fullTextView.textColor = UIColor.blackColor;
    _fullTextView.textAlignment = NSTextAlignmentLeft;
    _fullTextView.editable = NO;
    _fullTextView.layer.cornerRadius = 10;
    _fullTextView.alpha = 0.4;
    [self.contentView addSubview: _fullTextView];
}

- (void)prepareImportanceView
{
    _importanceView = [UIView new];
    [self.contentView addSubview:_importanceView];

}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.contentView.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
}


#pragma mark - Overriden setters

- (void)setTitle:(NSString *)title
{
    if (!title || title.length == 0)
    {
        return;
    }
    _title = title;
    self.titleLabel.text = title;
}

- (void)setFullText:(NSString *)fullText
{
    if (!fullText || fullText.length == 0)
    {
        return;
    }
    _fullText = fullText;
    self.fullTextView.text = fullText;
}

- (void)setImportance:(int64_t)importance
{
    if (importance <= 0 || importance > 5)
    {
        return;
    }
    self.importanceView.backgroundColor = [UNDTemplatesUI colorForImportance:importance];
}


#pragma mark - Constraints

- (void)layoutSubviews
{
    UIEdgeInsets paddings = UIEdgeInsetsMake(10, 15, 10, 10);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(paddings.top);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(paddings.left);
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-paddings.right);
        make.height.equalTo(@40);
    }];
    
    [self.fullTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(paddings.top);
        make.leading.equalTo(self.contentView.mas_leading).with.offset(paddings.left);
        make.trailing.equalTo(self.contentView.mas_trailing).with.offset(-paddings.right);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-paddings.bottom);
    }];
    
    [self.importanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.leading.equalTo(self.contentView.mas_leading);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(@7);
    }];
}


@end


