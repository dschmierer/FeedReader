//
//  FeedViewController.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedView.h"

@interface FeedViewController ()

@property (nonatomic, strong) FeedView *myView;

@end

@implementation FeedViewController

- (void)loadView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    _myView = [[FeedView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.view = _myView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_myView setTitle:@"hello world"];
}

@end
