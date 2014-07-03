//
//  ViewController.m
//  UncaughtException
//
//  Created by thinkit  on 7/3/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)throwFakeException:(id)sender
{
    NSException *uncaughtExcetion = [[NSException alloc] initWithName:@"Fake Exception"
                                                               reason:@"DEV UNHAPPY"
                                                             userInfo:[NSDictionary dictionaryWithObject:@"Extra info" forKey:@"Key"]];
    [uncaughtExcetion raise];
}
@end
