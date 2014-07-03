//
//  ViewController.h
//  UncaughtException
//
//  Created by thinkit  on 7/3/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *triggerButton;

- (IBAction)throwFakeException:(id)sender;

@end
