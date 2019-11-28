//
//  AppDelegate.m
//  feedReader
//
//  Created by David Schmierer on 11/27/19.
//  Copyright © 2019 David Schmierer. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, readwrite, nonatomic) UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    _navigationController = [[UINavigationController alloc] initWithRootViewController:[[FeedViewController alloc] initWithNibName:nil bundle:nil]];

    self.window.rootViewController = _navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
