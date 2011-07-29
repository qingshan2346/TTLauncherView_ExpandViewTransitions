//
//  LauncherViewController.h
//  -
//
//  Created by Adar Porat on 7/28/11.
//  Copyright 2011 Kosher Penguin LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface LauncherViewController : TTViewController <TTLauncherViewDelegate> {
  TTLauncherView* _launcherView;  
  TTImageView* _backgroundView;
  
  NSString* _urlToOpen;
  UIViewController* _viewController;
}

@end
