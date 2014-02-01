//
//  DBImagePickerViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 01/02/2014.
//  Copyright (c) 2014 Daniel Bennett. All rights reserved.
//

#import "DBImagePickerViewController.h"

@interface DBImagePickerViewController ()

@end

@implementation DBImagePickerViewController

- (BOOL) prefersStatusBarHidden
{
	return YES;
}

- (UIViewController *) childViewControllerForStatusBarHidden
{
	return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
