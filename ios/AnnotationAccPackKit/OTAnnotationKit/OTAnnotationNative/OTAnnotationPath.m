//
//  ScreenSharePath.m
//
//  Copyright © 2016 Lucas Huang. All rights reserved.
//

#import "OTAnnotationPath.h"

@interface OTAnnotationPoint()
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGPoint point;
@end

@implementation OTAnnotationPoint

+ (instancetype)pointWithX:(CGFloat)x andY:(CGFloat)y {
    OTAnnotationPoint *pt = [[OTAnnotationPoint alloc] init];
    pt.x = x;
    pt.y = y;
    return pt;
}

- (CGPoint)cgPoint {
    return CGPointMake(_x, _y);
}
@end

@interface OTAnnotationPath()
@property (nonatomic) UIColor *strokeColor;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) NSMutableArray<OTAnnotationPoint *> *mutablePoints;
@end

@implementation OTAnnotationPath

- (NSArray<OTAnnotationPoint *> *)points {
    return [_mutablePoints copy];
}

+ (instancetype)pathWithStrokeColor:(UIColor *)strokeColor {
    OTAnnotationPath *path = [[OTAnnotationPath alloc] init];
    path.mutablePoints = [[NSMutableArray alloc] init];
    path.strokeColor = strokeColor;
    path.lineWidth = 3.0f;
    return path;
}

+ (instancetype)pathWithPoints:(NSArray<OTAnnotationPoint *> *)points
                   strokeColor:(UIColor *)strokeColor {
    OTAnnotationPath *path = [[OTAnnotationPath alloc] init];
    path.mutablePoints = [[NSMutableArray alloc] initWithArray:points];
    path.strokeColor = strokeColor;
    path.lineWidth = 3.0f;
    
    OTAnnotationPoint *startPoint = [points firstObject];
    OTAnnotationPoint *endPoint = [points lastObject];
    path.startPoint = CGPointMake(startPoint.x, startPoint.y);
    path.endPoint = CGPointMake(endPoint.x, endPoint.y);
    
    return path;
}

- (void)drawWholePath {
    
    OTAnnotationPoint *firstPoint = [self.points firstObject];
    
    [self moveToPoint:[firstPoint cgPoint]];
    for (NSUInteger i = 1; i < self.points.count - 1; i++) {
        OTAnnotationPoint *thisPoint = self.points[i];
        [self addLineToPoint:[thisPoint cgPoint]];
    }
    
    OTAnnotationPoint *lastPoint = [self.points lastObject];
    [self addLineToPoint:[lastPoint cgPoint]];
}

- (void)drawAtPoint:(OTAnnotationPoint *)touchPoint {
    
    CGPoint point = [touchPoint cgPoint];
    [self moveToPoint:point];
    [self addPoint:touchPoint];
}

- (void)drawToPoint:(OTAnnotationPoint *)touchPoint {
    
    CGPoint p = [touchPoint cgPoint];
    [self addLineToPoint:p];
    [self addPoint:touchPoint];
}

#pragma mark - private method
- (void)addPoint:(OTAnnotationPoint *)touchPoint {
    if (_mutablePoints.count == 0) {
        _startPoint = [touchPoint cgPoint];
    }
    [_mutablePoints addObject:touchPoint];
    _endPoint = [touchPoint cgPoint];
}
@end
