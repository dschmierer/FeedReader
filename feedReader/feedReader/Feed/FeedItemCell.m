//
//  FeedItemCell.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedItemCell.h"

@interface FeedItemCell ()

@property (nonatomic, strong) UIStackView *containerStackView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation FeedItemCell

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
    self.backgroundColor = [UIColor yellowColor];
    [self setupContainerStackView];
    [self setupImageView];
    [self setupTitleLabel];
    [self setupTextView];
}

- (void)setupContainerStackView {
    _containerStackView = [[UIStackView alloc] init];
    _containerStackView.translatesAutoresizingMaskIntoConstraints = false;
    _containerStackView.axis = UILayoutConstraintAxisVertical;
}

- (void)setupImageView {
    _imageView = [[UIImageView alloc] init];
}

- (void)setupTitleLabel {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
}

- (void)setupTextView {
    _textView = [[UITextView alloc] init];
}

- (void)setupLayer {
    [self.contentView addSubview:_containerStackView];
    [_containerStackView addArrangedSubview:_imageView];
    [_containerStackView addArrangedSubview:_titleLabel];
    [_containerStackView addArrangedSubview:_textView];
}

- (void)setupConstraints {
    [self setupContainerStackViewConstraints];
}

- (void)setupContainerStackViewConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_containerStackView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
}

// MARK: - Public

- (void)setImageUrl:(NSURL *)imageUrl {
    _imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

- (void)setText:(NSString *)text {
    _textView.text = text;
}

@end
