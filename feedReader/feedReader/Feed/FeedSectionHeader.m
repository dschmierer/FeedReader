//
//  FeedSectionHeader.m
//  feedReader
//
//  Created by David Schmierer on 12/2/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedSectionHeader.h"

static CGFloat const kFeedSectionHeaderFontSize = 18;

@interface FeedSectionHeader ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FeedSectionHeader

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];

    if (self) {
        [self setupAll];
    }

    return self;
}

- (void)setupAll {
    [self setup];
    [self setupLayer];
    [self setupConstraints];
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];

    [self setupTitleLabel];
}

- (void)setupTitleLabel {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 1;
    _titleLabel.font = [UIFont systemFontOfSize:kFeedSectionHeaderFontSize weight:UIFontWeightMedium];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)setupLayer {
    [self addSubview:_titleLabel];
}

- (void)setupConstraints {
    [self setupTitleLabelConstraints];
}

- (void)setupTitleLabelConstraints {
    // Pin edges to view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-10.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:10.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
}

// MARK: - Override
- (void)prepareForReuse {
    _titleLabel.text = nil;
    [super prepareForReuse];
}

// MARK: - Public
- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
