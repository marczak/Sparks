//
//  Spark.h
//  Spark
//
//  Created by Edward Marczak on 6/12/13.
//  Copyright (c) 2013 Radiotope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Spark : NSObject {
  int size;
  NSPoint center;
  NSPoint circleCenter;
  float dropDelta;
  
  NSColor *circleColor;
  float curAlpha;
  float thickness;
  int finalSize;
  
  bool growing;
  
  bool alive;
}

@property int size;
@property float curAlpha;
@property float thickness;
@property int finalSize;
@property NSPoint circleCenter;
@property NSColor *circleColor;
@property bool growing;

- (void)initCircle:(NSRect)screenRect;
- (void)sparkLife;
- (BOOL)isAlive;

@end
