//
//  DBBaseViewController.m
//  Auditr
//
//  Created by Daniel Bennett on 11/12/2013.
//  Copyright (c) 2013 Daniel Bennett. All rights reserved.
//

#import "DBBaseViewController.h"
#import "DBBaseViewModel.h"

@interface DBBaseViewController ()

@property (nonatomic, weak) DBBaseViewModel *viewModel;

@end

@implementation DBBaseViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder: aDecoder];
	if(self)
	{
		DBAssembly *factory = (DBAssembly *)[TyphoonAssembly defaultAssembly];
		self.viewModel = (DBBaseViewModel *)[factory baseViewModel];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
