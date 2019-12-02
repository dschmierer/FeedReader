//
//  WebViewController.m
//  feedReader
//
//  Created by David Schmierer on 12/1/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) WKWebView *myView;
@property (nonatomic, strong) UIBarButtonItem *doneButton;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *titleString;

@end

@implementation WebViewController

- (id)initWithURL:(NSURL *)url title:(NSString *)title {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        self.url = url;
        self.titleString = title;
    }

    return self;
}

- (void)loadView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    _myView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.view = _myView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleString;
    [_myView loadRequest:[NSURLRequest requestWithURL:_url]];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
    [self.navigationItem setLeftBarButtonItem:_doneButton];
}

- (void)donePressed {
    [_delegate webViewControllerDonePressed:self];
}

@end
