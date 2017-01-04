//
//  ReceiveAnnotationViewController.m
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

#import "ReceiveAnnotationViewController.h"
#import "OTAnnotator.h"
#import "OTScreenSharer.h"

#import "AppDelegate.h"

@interface ReceiveAnnotationViewController () <OTScreenShareDataSource, OTAnnotationToolbarViewDataSource>
@property (nonatomic) OTAnnotator *annotator;
@property (nonatomic) OTScreenSharer *sharer;

@property (weak, nonatomic) IBOutlet UIView *toolbarContainerView;
@property (weak, nonatomic) IBOutlet UIView *shareView;

@end

@implementation ReceiveAnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Receive Annotation";
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.sharer = [[OTScreenSharer alloc] init];
    self.sharer.dataSource = self;
    [self.sharer connectWithView:self.shareView
                         handler:^(OTScreenShareSignal signal, NSError *error) {
                             
                             if (!error) {
                                 
                                 if (signal == OTScreenSharePublisherCreated) {
                                     self.sharer.publishAudio = NO;
                                     self.sharer.subscribeToAudio = NO;
                                     
                                     self.annotator = [[OTAnnotator alloc] init];
                                     self.annotator.dataSource = self;
                                     [self.annotator connectWithCompletionHandler:^(OTAnnotationSignal signal, NSError *error) {
                                         if (signal == OTAnnotationSessionDidConnect){
                                             self.annotator.annotationScrollView.frame = self.shareView.bounds;
                                             self.annotator.annotationScrollView.scrollView.contentSize = self.shareView.bounds.size;
                                             [self.shareView addSubview:self.annotator.annotationScrollView];
                                             
                                             [self.annotator.annotationScrollView initializeToolbarView];
                                             self.annotator.annotationScrollView.toolbarView.toolbarViewDataSource = self;
                                             
                                             // using frame and self.view to contain toolbarView is for having more space to interact with color picker
                                             self.annotator.annotationScrollView.toolbarView.frame = self.toolbarContainerView.frame;
                                             [self.view addSubview:self.annotator.annotationScrollView.toolbarView];
                                         }
                                     }];
                                     
                                     self.annotator.dataReceivingHandler = ^(NSArray *data) {
                                         NSLog(@"%@", data);
                                     };
                                 }
                             }
                         }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.annotator disconnect];
    self.annotator = nil;
    [self.sharer disconnect];
    self.sharer = nil;
}

- (UIView *)annotationToolbarViewForRootViewForScreenShot:(OTAnnotationToolbarView *)toolbarView {
    return self.shareView;
}

- (OTAcceleratorSession *)sessionOfOTAnnotator:(OTAnnotator *)annotator {
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] getSharedAcceleratorSession];
}

- (OTAcceleratorSession *)sessionOfOTScreenSharer:(OTScreenSharer *)screenSharer {
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] getSharedAcceleratorSession];
}

@end
