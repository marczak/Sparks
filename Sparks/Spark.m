//
//  circle.m
//  circle
//
//  Created by Edward Marczak on 6/12/13.
//  Copyright (c) 2013 Radiotope. All rights reserved.
//

#import "Spark.h"
#import <ScreenSaver/ScreenSaver.h>

@implementation Spark

@synthesize curAlpha;
@synthesize thickness;
@synthesize size;
@synthesize circleCenter;
@synthesize circleColor;
@synthesize growing;
@synthesize finalSize;

- (void)initCircle:(NSRect)screenRect {
  size = 0;
  finalSize = SSRandomIntBetween(3, 15);
  dropDelta = SSRandomFloatBetween(0.1, 1.1);
  center = NSMakePoint(screenRect.size.width / 2,
                       screenRect.size.height / 2);
  circleCenter = NSMakePoint(random() % (int)screenRect.size.width,
                                   random() % (int)screenRect.size.height);
  
  curAlpha = 1.0;
  // TODO(marczak): make this a selectable option.
//  circleColor = [NSColor colorWithCalibratedRed:SSRandomFloatBetween(0.0, 1.0)
//                                                green:SSRandomFloatBetween(0.0, 1.0)
//                                                 blue:SSRandomFloatBetween(0.0, 1.0)
//                                                alpha:curAlpha];
  // Green
//  circleColor = [NSColor colorWithCalibratedRed:0.0
//                                          green:SSRandomFloatBetween(0.3, 1.0)
//                                           blue:0.0
//                                          alpha:curAlpha];
  // Firefly
  circleColor = [NSColor colorWithCalibratedRed:SSRandomFloatBetween(0.7, 1.0)
                                          green:SSRandomFloatBetween(0.8, 1.0)
                                           blue:0.0
                                          alpha:curAlpha];
  // Rain
//  circleColor = [NSColor colorWithCalibratedRed:0.0
//                                          green:0.0
//                                           blue:SSRandomFloatBetween(0.8, 1.0)
//                                          alpha:curAlpha];

  thickness = 1.0;
  growing = true;
  
  alive = true;
}

- (void)sparkLife {
  if (growing) {
    size += 1;
  } else {
    if (size > 0) {
      size -= 1;
    }
  }

  if (size >= finalSize || !growing) {
    curAlpha -= 0.01;
    thickness += 0.3;
    growing = false;
  }
  
  if (curAlpha < 0.15) {
    alive = false;
  }
  
  circleCenter.y -= dropDelta;
}

- (BOOL)isAlive {
  return alive;
}

@end
