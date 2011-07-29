//
//  SplitViewAppDelegate.m
//  -
//
//  Created by Adar Porat on 7/28/11.
//  Copyright 2011 Kosher Penguin LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "Three20/Three20.h"

#import "LauncherViewController.h"
#import "View1Controller.h"
#import "StyleSheet.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AppDelegate



///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application 
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  [TTStyleSheet setGlobalStyleSheet:[[[StyleSheet alloc] init] autorelease]];

  TTNavigator* navigator = [TTNavigator navigator];
  navigator.persistenceMode = TTNavigatorPersistenceModeTop;
  
  TTURLMap* map = navigator.URLMap;
  
  [map from:@"*" toViewController:[TTWebController class]];
  [map from:@"portal://launcher" toViewController:[LauncherViewController class]];
  [map from:@"portal://view1" toModalViewController:[View1Controller class] transition:UIViewAnimationTransitionNone];
  [map from:@"portal://view2" toModalViewController:[View1Controller class] transition:UIViewAnimationTransitionNone];

  [navigator openURLAction:[TTURLAction actionWithURLPath:@"portal://launcher"]];

  
  return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  [super dealloc];
}

@end
