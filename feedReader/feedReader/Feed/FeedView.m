//
//  FeedView.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedView.h"

@interface FeedView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FeedView

// MARK: - Override

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];

    if (self) {
        [self setupAll];
    }

    return self;
}

// MARK: - Private

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
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)setupLayer {
    [self addSubview:_titleLabel];
}

- (void)setupConstraints {
    [self setupTitleLabelConstraints];
}

- (void)setupTitleLabelConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
}


// MARK: - Public

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
