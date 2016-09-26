//
//  AnnotationImportedViewController.swift
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

import UIKit

class AnnotationImportedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.translucent = false
        let topOffset = UIApplication.sharedApplication().statusBarFrame.size.height + CGRectGetHeight(navigationController!.navigationBar.frame)
        let heightOfToolbar = CGFloat(50)
        
        guard let image = UIImage(named: "mvc") else {
            return;
        }
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let screenShareView = OTAnnotationScrollView()
        screenShareView.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), CGRectGetHeight(UIScreen.mainScreen().bounds) - heightOfToolbar - topOffset)
        screenShareView.scrollView.contentSize = image.size
        
        screenShareView.addContentView(imageView)
        
        screenShareView.initializeToolbarView()
        screenShareView.toolbarView!.frame = CGRectMake(0, CGRectGetHeight(UIScreen.mainScreen().bounds) - heightOfToolbar - topOffset, CGRectGetWidth(UIScreen.mainScreen().bounds), heightOfToolbar)
        
        self.view.addSubview(screenShareView)
        self.view.addSubview(screenShareView.toolbarView!)
    }
}
