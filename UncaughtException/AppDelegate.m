//
//  AppDelegate.m
//  UncaughtException
//
//  Created by thinkit  on 7/3/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
#ifndef TARGET_IPHONE_SIMULATOR
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if ( [settings boolForKey:@"ExceptionOccuredOnLastRun"])
    {
        // reset flag
        [settings setBool:NO forKey:@"ExceptionOccuredOnLastRun"];
        [settings synchronize];
        
        
        // show an alert to user
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"UncaughtException occured on last run"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alertView addButtonWithTitle:@"Send Email"];
        [alertView show];
    }
    else
    {
        NSSetUncaughtExceptionHandler(&myUncaughtExceptionHandler);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [paths objectAtIndex:0];
        NSString *stderrFile = [documentPath stringByAppendingPathComponent:@"stderr.log"];
        
        // Redirect stderr output to file
        freopen([stderrFile cStringUsingEncoding:NSASCIIStringEncoding], "w", stderr);
    }
    
#endif
  
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UNcaughtExceptionHandler

void myUncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"Uncaught exception: %@ \nReason:%@\n User info: %@\n CallStackSymbol:%@\n", exception.name, exception.reason, exception.userInfo, exception.callStackSymbols);
     NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
     [settings setBool:YES forKey:@"ExceptionOccuredOnLastRun"];
     [settings synchronize];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *stderrFile = [documentPath stringByAppendingPathComponent:@"stderr.log"];
    
    if (buttonIndex == 1)
    {
        // Send email
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:@"Error Report"];
        [mailComposer setToRecipients:[NSArray arrayWithObject:@"lisai@thinkit.cn"]];
        
        // Attach log file
        NSData *data = [NSData dataWithContentsOfFile:stderrFile];
        [mailComposer addAttachmentData:data mimeType:@"Text/XML" fileName:@"stderr.log"];
        
        // Compose email body
        UIDevice *device = [UIDevice currentDevice];
        NSString *messageBody = [NSString stringWithFormat:@"Device model:%@\n OS:%@\n OS version:%@\n", device.model, device.systemName, device.systemVersion];
        [mailComposer setMessageBody:messageBody isHTML:NO];
        
        [self.window.rootViewController presentViewController:mailComposer animated:YES completion:nil];        
    }
    
    NSSetUncaughtExceptionHandler(&myUncaughtExceptionHandler);
    
    // Redirect stderr output to file
    freopen([stderrFile cStringUsingEncoding:NSASCIIStringEncoding], "w", stderr);
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
