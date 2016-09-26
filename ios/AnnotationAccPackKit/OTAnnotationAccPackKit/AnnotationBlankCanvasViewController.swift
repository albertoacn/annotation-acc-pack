//
//  AnnotationBlankViewController.swift
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

class AnnotationBlankCanvasViewController: UIViewController {
    
    let topOffset: CGFloat = 20 + 44
    let topOffsetForLandscape: CGFloat = 44
    let heightOfToolbar = CGFloat(50)
    let widthOfToolbar = CGFloat(50)
    let annotationScrollView = OTAnnotationScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.translucent = false
        
        annotationScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), CGRectGetHeight(UIScreen.mainScreen().bounds) - heightOfToolbar - topOffset)
        annotationScrollView.scrollView.contentSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds), CGRectGetHeight(UIScreen.mainScreen().bounds) - heightOfToolbar - topOffset)
        
        annotationScrollView.initializeToolbarView()
        annotationScrollView.toolbarView!.frame = CGRectMake(0, CGRectGetHeight(UIScreen.mainScreen().bounds) - heightOfToolbar - topOffset, CGRectGetWidth(UIScreen.mainScreen().bounds), heightOfToolbar)
        
        view.addSubview(annotationScrollView)
        view.addSubview(annotationScrollView.toolbarView!)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenRect = UIScreen.mainScreen().bounds;
        
        // portrait
        if CGRectGetWidth(screenRect) < CGRectGetHeight(screenRect) {
            annotationScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(screenRect), CGRectGetHeight(screenRect) - heightOfToolbar - topOffset)
            annotationScrollView.scrollView.contentSize = CGSizeMake(CGRectGetWidth(screenRect), CGRectGetHeight(screenRect) - heightOfToolbar - topOffset)
            
            annotationScrollView.toolbarView!.frame = CGRectMake(0, CGRectGetHeight(screenRect) - heightOfToolbar - topOffset, CGRectGetWidth(screenRect), heightOfToolbar)
            annotationScrollView.toolbarView?.toolbarViewOrientation = .PortraitlBottom
        }
        else {
            
            // landscape left
//            annotationScrollView.frame = CGRectMake(widthOfToolbar, 0, CGRectGetWidth(screenRect) - widthOfToolbar, CGRectGetHeight(screenRect) - topOffsetForLandscape)
//            annotationScrollView.scrollView.contentSize = CGSizeMake(CGRectGetWidth(screenRect) - widthOfToolbar, CGRectGetHeight(screenRect) - topOffsetForLandscape)
//            
//            annotationScrollView.toolbarView!.frame = CGRectMake(0, 0, widthOfToolbar, CGRectGetHeight(screenRect) - topOffsetForLandscape)
//            annotationScrollView.toolbarView?.toolbarViewOrientation = .LandscapeLeft

            // landscape right
            annotationScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(screenRect) - widthOfToolbar, CGRectGetHeight(screenRect) - topOffsetForLandscape)
            annotationScrollView.scrollView.contentSize = CGSizeMake(CGRectGetWidth(screenRect) - widthOfToolbar, CGRectGetHeight(screenRect) - topOffsetForLandscape)
            
            annotationScrollView.toolbarView!.frame = CGRectMake(CGRectGetWidth(screenRect) - widthOfToolbar, 0, widthOfToolbar, CGRectGetHeight(screenRect) - topOffsetForLandscape)
            annotationScrollView.toolbarView?.toolbarViewOrientation = .LandscapeRight
        }
    }
}
