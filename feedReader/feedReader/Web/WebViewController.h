//
//  WebViewController.h
//  feedReader
//
//  Created by David Schmierer on 12/1/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol WebViewControllerDelegate <NSObject>

- (void)webViewControllerDonePressed:(id)webViewController;

@end

@interface WebViewController : UIViewController

@property (nonatomic, weak) id <WebViewControllerDelegate> delegate;

- (id)initWithURL:(NSURL *)url title:(NSString *)title;

@end
