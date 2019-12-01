//
//  FeedItem.m
//  feedReader
//
//  Created by David Schmierer on 12/1/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedItem.h"

@interface FeedItem ()

@property (nonatomic, strong) NSDictionary *data;
@property BOOL imageReady;
@property (nonatomic, strong) UIImage *itemImage;
@property (nonatomic, strong) NSURLSessionDownloadTask *imageDownloadTask;
@property (nonatomic, strong) NSString *itemImageUrl;
@property (nonatomic, strong) NSString *itemDateStr;
@property (nonatomic, strong) NSString *itemUrlStr;

@end

@implementation FeedItem

- (id)initWithDict:(NSDictionary *)data {
    self = [super init];

    if (self) {
        _data = data;
        _imageReady = false;
        _itemImageUrl = [FeedItem getValueFrom:data primaryKey:@"media:content" secondaryKey:@"url"];
        _itemTitle = [[[FeedItem getValueFrom:data primaryKey:@"title" secondaryKey:@"text"] stringByRemovingPercentEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _itemDescription = [[[FeedItem getValueFrom:data primaryKey:@"description" secondaryKey: @"text"] stringByRemovingPercentEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _itemDateStr = [FeedItem getValueFrom:data primaryKey:@"pubDate" secondaryKey:@"text"];
        _itemUrlStr = [FeedItem getValueFrom:data primaryKey:@"link" secondaryKey:@"text"];
    }
    return self;
}

// MARK: - Public
- (void)loadImageIfNeeded {
    if (_imageDownloadTask != nil) {
        return;
    }

    NSURL *url = [NSURL URLWithString:
      _itemImageUrl];
    __weak FeedItem *weakSelf = self;
    _imageDownloadTask = [[NSURLSession sharedSession]
     downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        weakSelf.imageReady = true;
        weakSelf.itemImage = image;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.delegate feedItem:weakSelf imageDidLoad:image];
        });
    }];

    [_imageDownloadTask resume];
}

// MARK: - Static
+ (NSString *)getValueFrom:(NSDictionary *)data primaryKey:(NSString *)primaryKey secondaryKey:(NSString *)secondaryKey {
    id value = [data objectForKey:primaryKey];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return [value objectForKey:secondaryKey];
    }
    NSLog(@"Error: could not read key %@", primaryKey);
    return @"";
}

@end
