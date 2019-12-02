//
//  FeedItem.h
//  feedReader
//
//  Created by David Schmierer on 12/1/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedItemDelegate <NSObject>

- (void)feedItem:(id)feedItem imageDidLoad:(UIImage *)image;

@end

@interface FeedItem : NSObject

@property (readonly) BOOL imageReady;
@property (readonly) UIImage *itemImage;
@property (readonly) NSString *itemTitle;
@property (readonly) NSString *itemDescription;
@property (readonly) NSURL *itemUrl;

@property (nonatomic, weak) id <FeedItemDelegate> delegate;

- (id)initWithDict:(NSDictionary *)data;
- (void)loadImageIfNeeded;

@end

