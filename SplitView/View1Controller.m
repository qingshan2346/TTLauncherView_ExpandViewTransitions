//
//  SettingsController.m
//  -
//
//  Created by Adar Porat on 7/28/11.
//  Copyright 2011 Kosher Penguin LLC. All rights reserved.
//

#import "View1Controller.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation View1Controller


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    
    self.title = @"Launcher Demo";
    
    TTButton* backButton = [TTButton buttonWithStyle:@"grayToolbarButton:"];
    backButton.frame = CGRectMake(0,0,36,36);
    [backButton setImage:@"bundle://back.png" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector (dismissController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
  }
  
  return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dismissController {
  [self.navigationController popViewControllerAnimated:NO];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor yellowColor];

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}



@end
