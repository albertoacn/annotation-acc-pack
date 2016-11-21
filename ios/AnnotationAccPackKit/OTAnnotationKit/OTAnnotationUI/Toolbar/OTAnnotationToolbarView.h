//
//  OTAnnotationToolbarView.h
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OTAnnotationKit/OTAnnotationPath.h>
#import <OTAnnotationKit/OTAnnotationTextView.h>

@class OTAnnotationToolbarView;
@protocol OTAnnotationToolbarViewDataSource <NSObject>

@optional
- (UIView *)annotationToolbarViewForRootViewForScreenShot:(OTAnnotationToolbarView *)toolbarView;

@end

@protocol OTAnnotationToolbarViewDelegate <NSObject>

@optional
- (void)annotationToolbarViewDidPressDoneButton:(OTAnnotationToolbarView *)annotationToolbarView;

- (void)annotationToolbarViewDidSelectDrawButton:(OTAnnotationToolbarView *)annotationToolbarView
                                            path:(OTAnnotationPath *)path;

- (void)annotationToolbarViewDidPressEraseButton:(OTAnnotationToolbarView *)annotationToolbarView;

- (void)annotationToolbarViewDidPressCleanButton:(OTAnnotationToolbarView *)annotationToolbarView;

- (void)annotationToolbarViewDidStartTextAnnotation:(OTAnnotationToolbarView *)annotationToolbarView;

- (void)annotationToolbarViewDidAddTextAnnotation:(OTAnnotationToolbarView *)annotationToolbarView
                               annotationTextView:(OTAnnotationTextView *)textView;

- (void)annotationToolbarViewDidCancelTextAnnotation:(OTAnnotationToolbarView *)annotationToolbarView
                                  annotationTextView:(OTAnnotationTextView *)textView;

@end

typedef NS_ENUM(NSUInteger, OTAnnotationToolbarViewOrientation) {
    OTAnnotationToolbarViewOrientationPortraitlBottom = 0,
    OTAnnotationToolbarViewOrientationLandscapeLeft,
    OTAnnotationToolbarViewOrientationLandscapeRight
};

@interface OTAnnotationToolbarView : UIView

/**
 *  The object that acts as the data source of the annotation toolbar view.
 *
 *  The delegate must adopt the OTAnnotationToolbarViewDataSource protocol. The data source is not retained.
 */
@property (weak, nonatomic) id<OTAnnotationToolbarViewDataSource> toolbarViewDataSource;

/**
 *  The object that acts as the delegate object of the annotation toolbar view.
 *
 *  The delegate must adopt the OTAnnotationToolbarViewDelegate protocol. The delegate object is not retained.
 */
@property (weak, nonatomic) id<OTAnnotationToolbarViewDelegate> toolbarViewDelegate;

/**
 *  The orientation of this annotation toolbar.
 *
 *  @discussion The default value is OTAnnotationToolbarViewOrientationPortraitlBottom. It assumes the position of toolbar view is at the bottom and all assosiated animation will be performed upwards.
 *  Set it to OTAnnotationToolbarViewOrientationLandscapeLeft, it assumes the position of toolbar view is on the left and all assosiated animation will be performed towards right.
 *  Set it to OTAnnotationToolbarViewOrientationLandscapeRight, it assumes the position of toolbar view is on the right and all assosiated animation will be performed towards left.
 *
 */
@property (nonatomic) OTAnnotationToolbarViewOrientation toolbarViewOrientation;

@end
