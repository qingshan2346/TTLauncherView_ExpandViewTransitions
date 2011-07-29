//
//  LauncherViewController.m
//  -
//
//  Created by Adar Porat on 7/28/11.
//  Copyright 2011 Kosher Penguin LLC. All rights reserved.
//

#import "LauncherViewController.h"

#define TIME_FOR_SHRINKING 0.60f 
#define TIME_FOR_EXPANDING 0.60f
#define SCALED_DOWN_AMOUNT 0.01 

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation LauncherViewController



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  TT_RELEASE_SAFELY(_launcherView);
  TT_RELEASE_SAFELY(_viewController)
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  if (_viewController) {
    [self shrinkTransition:[NSNumber numberWithFloat:TIME_FOR_SHRINKING]];
  }


}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return UIDeviceOrientationIsPortrait(interfaceOrientation);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
  [super loadView];

  _backgroundView = [[[TTImageView alloc] initWithFrame:self.view.bounds] autorelease];
  

  _backgroundView.urlPath = @"bundle://Launcher.png";    
  
  [self.view addSubview:_backgroundView];
  
  _launcherView = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
  _launcherView.backgroundColor = [UIColor clearColor];
  _launcherView.delegate = self;
  _launcherView.columnCount = 3;
  _launcherView.persistenceMode = TTLauncherPersistenceModeNone;
  
  if (![_launcherView restoreLauncherItems]) {
    _launcherView.pages = [NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:
                            [[[TTLauncherItem alloc] initWithTitle:@"Button 1"
                                                             image:@"bundle://Icon.png"
                                                               URL:@"portal://view2" canDelete:YES] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Button 2"
                                                             image:@"bundle://Icon.png"
                                                               URL:@"portal://view2" canDelete:YES] autorelease],
                            nil],
                           [NSArray arrayWithObjects:
                            [[[TTLauncherItem alloc] initWithTitle:@"Button 8"
                                                             image:@"bundle://Icon.png"
                                                               URL:@"portal://view2" canDelete:YES] autorelease],
                            [[[TTLauncherItem alloc] initWithTitle:@"Button 9"
                                                             image:@"bundle://Icon.png"
                                                               URL:@"portal://view2" canDelete:YES] autorelease],
                            nil],
                           nil
                           ];
  }
  
  [self.view addSubview:_launcherView];

}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)expandTransition:(NSNumber*)duration {
  self.view.userInteractionEnabled=NO;
  _viewController = [[[TTNavigator navigator] viewControllerForURL:_urlToOpen] retain];
  
  [[self view] addSubview:_viewController.view];
  _viewController.view.frame=self.view.bounds;
  _viewController.view.transform=CGAffineTransformMakeScale(SCALED_DOWN_AMOUNT, SCALED_DOWN_AMOUNT);
  _viewController.view.hidden=false;
  _viewController.view.alpha = 0.0f;
  
  [UIView beginAnimations:@"animationExpand" context:NULL];
  [UIView setAnimationDuration:[duration floatValue]];
  _viewController.view.transform=CGAffineTransformMakeScale(1, 1);
  _viewController.view.alpha = 1.0f;
  
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
  [UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)shrinkTransition:(NSNumber*)duration {
 	[[self view] addSubview:_viewController.view];

  [UIView beginAnimations:@"animationShrink" context:NULL];
  [UIView setAnimationDuration:[duration floatValue]];
  _viewController.view.transform=CGAffineTransformMakeScale(SCALED_DOWN_AMOUNT, SCALED_DOWN_AMOUNT);
  [UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
  _viewController.view.alpha = 0.0f;

	[UIView commitAnimations];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)animationDidStop:(NSString *)animationID 
                finished:(BOOL)finished 
                 context:(void *)context {
  if ([animationID isEqualToString:@"animationExpand"]) {
    self.view.userInteractionEnabled=YES;
    [self.navigationController pushViewController:_viewController animated:NO];
  } else {
    _viewController.view.hidden=true;
    TT_RELEASE_SAFELY(_viewController);
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTLauncherViewDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
  _urlToOpen = [NSString stringWithString:item.URL];
  [self performSelector:@selector(expandTransition:) withObject:[NSNumber numberWithFloat: TIME_FOR_EXPANDING]];  
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
  [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:_launcherView action:@selector(endEditing)] autorelease] animated:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
  [self.navigationItem setRightBarButtonItem:nil animated:YES];
}


@end
