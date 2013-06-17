//
//  circleView.m
//  circle
//
//  Created by Edward Marczak on 6/11/13.
//  Copyright (c) 2013 Radiotope. All rights reserved.
//

#import "SparksView.h"
#import "Spark.h"

@implementation SparksView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
  self = [super initWithFrame:frame isPreview:isPreview];
  if (self) {
    srand((int)clock());
    [self setAnimationTimeInterval:1/30.0];
  }
  return self;
}

- (void)startAnimation
{
  [super startAnimation];
}

- (void)stopAnimation
{
  [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
  [super drawRect:rect];
  CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
  
  static NSMutableArray *sparks = nil;
  if (sparks == nil) {
    sparks = [[NSMutableArray alloc] init];
  }
  
  Spark *spark = [[Spark alloc] init];
  [spark initCircle:rect];
  
  if ([sparks count] < 100) {
    [sparks addObject:spark];
  }
  
  for (NSUInteger curIndex = 0; curIndex < [sparks count]; curIndex++) {
    Spark *aSpark = [sparks objectAtIndex:curIndex];
    [aSpark sparkLife];
    if (![aSpark isAlive]) {
      aSpark = nil;
      [sparks removeObjectAtIndex:curIndex];
    } else {
      
      // Draw Haze
      int hazeSize;
      if (aSpark.growing) {
        hazeSize = aSpark.size + 5;
      } else {
        hazeSize = aSpark.finalSize;
      }
      CGContextSetLineWidth(context, aSpark.thickness + 25);
      
      CGContextBeginPath(context);
      CGContextAddArc(context,
                      aSpark.circleCenter.x,
                      aSpark.circleCenter.y,
                      hazeSize, 0, 2*M_PI, YES);
      CGContextClosePath(context);
      
      CGContextSetRGBStrokeColor(context,
                                 [aSpark.circleColor redComponent],
                                 [aSpark.circleColor greenComponent],
                                 [aSpark.circleColor blueComponent],
                                 aSpark.curAlpha - 0.75);
      
      CGContextDrawPath(context, kCGPathFillStroke);

      // Draw Center
      CGContextSetLineWidth(context, aSpark.thickness);
      
      CGContextBeginPath(context);
      CGContextAddArc(context,
                      aSpark.circleCenter.x,
                      aSpark.circleCenter.y,
                      aSpark.size, 0, 2*M_PI, YES);
      CGContextClosePath(context);
      
      CGContextSetRGBStrokeColor(context,
                                 [aSpark.circleColor redComponent],
                                 [aSpark.circleColor greenComponent],
                                 [aSpark.circleColor blueComponent],
                                 aSpark.curAlpha);
      
      CGContextDrawPath(context, kCGPathStroke);
    }
    
  }
  
  // Plain old draw methods for status line
  // TODO(marczak): Make this an option
  NSColor *fg = [NSColor greenColor];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
  [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss z"];
  [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
  NSDate *date = [NSDate date];
  NSString *dateString = [dateFormatter stringFromDate:date];
//  NSString *dateString = [NSString stringWithFormat:@"count = %lu", (unsigned long)[sparks count]];
  
  int fontSize = 38;
  if ([self isPreview]) {
    fontSize = 12;
  }
  NSFont* font = [NSFont fontWithName: @"Arial" size:fontSize];
  
  NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                         font, NSFontAttributeName,
                         fg, NSForegroundColorAttributeName, nil];
  
  NSSize statusSize = [dateString sizeWithAttributes:attrs];
  
  [dateString drawAtPoint:NSMakePoint(rect.size.width - statusSize.width - 20, rect.size.height - (rect.size.height - statusSize.height)) withAttributes:attrs];
}

- (void)animateOneFrame
{
  [self setNeedsDisplay:YES];
  return;
}

- (BOOL)hasConfigureSheet
{
  return NO;
}

- (NSWindow*)configureSheet
{
  return nil;
}

@end
