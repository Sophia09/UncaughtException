//
//  AppDelegate.h
//  UncaughtException
//
//  Created by thinkit  on 7/3/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
