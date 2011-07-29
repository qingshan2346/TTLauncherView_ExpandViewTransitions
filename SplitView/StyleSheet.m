//
//  StyleSheet.m
//  -
//
//  Created by Adar Porat on 7/28/11.
//  Copyright 2011 Kosher Penguin LLC. All rights reserved.
//

#import "StyleSheet.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation StyleSheet


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTDefaultStyleSheet

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)launcherButton:(UIControlState)state {
  return
  [TTPartStyle styleWithName:@"image" style:TTSTYLESTATE(launcherButtonImage:, state) next:
   [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:13] color:RGBCOLOR(0, 0, 0)
              minimumFontSize:13 shadowColor:nil
                 shadowOffset:CGSizeZero next:nil]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (TTStyle*)grayToolbarButton:(UIControlState)state {
  TTShape* shape = [TTRoundedRectangleShape shapeWithRadius:4.5];
  UIColor* tintColor = RGBCOLOR(50, 50, 50);
  return [TTSTYLESHEET toolbarButtonForState:state shape:shape tintColor:tintColor font:nil];
}



@end
