//
//  CustomAnnotationView.swift
//  MapCallouts
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/11/8.
//
//
/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 The custom MKAnnotationView object representing a generic location, displaying a title and image.
 */

#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif
import MapKit

/// annotation view for the Tea Carbon
/// MKAnnotationView for the Tea Garden
@objc(CustomAnnotationView)
class CustomAnnotationView: MKAnnotationView {
    
    fileprivate let kMaxViewWidth: CGFloat = 150.0
    
    fileprivate let kViewWidth: CGFloat = 90
    fileprivate let kViewLength: CGFloat = 100
    
    fileprivate let kLeftMargin: CGFloat = 15.0
    fileprivate let kRightMargin: CGFloat = 5.0
    fileprivate let kTopMargin: CGFloat = 5.0
    fileprivate let kBottomMargin: CGFloat = 10.0
    fileprivate let kRoundBoxLeft: CGFloat = 10.0
    
    #if os(iOS)
    // iOS Label
    func makeiOSLabel(_ placeLabel: String?) -> UILabel {
        // add the annotation's label
        let annotationLabel = UILabel(frame: CGRect.zero)
        annotationLabel.font = UIFont.systemFont(ofSize: 9.0)
        annotationLabel.textColor = UIColor.white
        annotationLabel.text = placeLabel
        annotationLabel.sizeToFit()   // get the right vertical size
        
        // compute the optimum width of our annotation, based on the size of our annotation label
        let optimumWidth = annotationLabel.frame.size.width + kRightMargin + kLeftMargin
        var frame = self.frame
        if optimumWidth < kViewWidth {
            frame.size = CGSize(width: kViewWidth, height: kViewLength)
        } else if optimumWidth > kMaxViewWidth {
            frame.size = CGSize(width: kMaxViewWidth, height: kViewLength)
        } else {
            frame.size = CGSize(width: optimumWidth, height: kViewLength)
        }
        self.frame = frame
        
        annotationLabel.lineBreakMode = .byTruncatingTail
        annotationLabel.backgroundColor = UIColor.clear
        var newFrame = annotationLabel.frame
        newFrame.origin.x = kLeftMargin
        newFrame.origin.y = kTopMargin
        newFrame.size.width = self.frame.size.width - kRightMargin - kLeftMargin
        annotationLabel.frame = newFrame
        
        return annotationLabel
    }
    #else
    // OS X label
    func makeOSXLabel(placeLabel: String) -> NSTextField {
        let annotationLabel = NSTextField(frame: NSZeroRect)
        annotationLabel.bordered = false
        annotationLabel.editable = false
        annotationLabel.font = NSFont.systemFontOfSize(10.0)
        annotationLabel.textColor = NSColor.whiteColor()
        annotationLabel.stringValue = placeLabel
        annotationLabel.sizeToFit()   // get the right vertical size
        
        // compute the optimum width of our annotation, based on the size of our annotation label
        let optimumWidth = annotationLabel.frame.size.width + kRightMargin + kLeftMargin
        var frame = self.frame
        if optimumWidth < kViewWidth {
            frame.size = CGSizeMake(kViewWidth, kViewLength)
        } else if optimumWidth > kMaxViewWidth {
            frame.size = CGSizeMake(kMaxViewWidth, kViewLength)
        } else {
            frame.size = CGSizeMake(optimumWidth, kViewLength)
        }
        self.frame = frame
        
        annotationLabel.backgroundColor = NSColor.clearColor()
        var newFrame = annotationLabel.frame
        newFrame.origin.x = kLeftMargin
        newFrame.origin.y = kTopMargin
        newFrame.size.width = self.frame.size.width - kRightMargin - kLeftMargin
        annotationLabel.frame = newFrame
        
        return annotationLabel
    }
    #endif
    
    // determine the MKAnnotationView based on the annotation info and reuseIdentifier
    //
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let mapItem = self.annotation as! CustomAnnotation
        
        // offset the annotation so it won't obscure the actual lat/long location
        self.centerOffset = CGPoint(x: 50.0, y: 50.0)
        
        #if os(iOS)
            // iOS equivalent
            //
            self.backgroundColor = UIColor.clear
            
            let annotationLabel = self.makeiOSLabel(mapItem.place)
            self.addSubview(annotationLabel)
            
            // add the annotation's image
            // the annotation image snaps to the width and height of this view
            let annotationImage = UIImageView(image: UIImage(named: mapItem.imageName!))
            annotationImage.contentMode = UIViewContentMode.scaleAspectFit
            annotationImage.frame =
                CGRect(x: kLeftMargin,
                    y: annotationLabel.frame.origin.y + annotationLabel.frame.size.height + kTopMargin,
                    width: self.frame.size.width - kRightMargin - kLeftMargin,
                    height: self.frame.size.height - annotationLabel.frame.size.height - kTopMargin*2 - kBottomMargin)
            self.addSubview(annotationImage)
            
        #else
            // OS X equivalent
            //
            let annotationLabel = self.makeOSXLabel(mapItem.place!)
            self.addSubview(annotationLabel)
            
            // add the annotation's image
            // the annotation image snaps to the width and height of this view
            let annotationImage = NSImage(named: mapItem.imageName!)
            let annotationImageFrame = NSMakeRect(0, 0, annotationImage!.size.width, annotationImage!.size.height)
            let annotationImageView = NSImageView(frame: annotationImageFrame)
            annotationImageView.image = annotationImage
            
            annotationImageView.frame =
                NSMakeRect(kLeftMargin,
                    annotationLabel.frame.origin.y + annotationLabel.frame.size.height + kTopMargin,
                    self.frame.size.width - kRightMargin - kLeftMargin,
                    self.frame.size.height - annotationLabel.frame.size.height - kTopMargin*2 - kBottomMargin)
            self.addSubview(annotationImageView)
        #endif
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if os(iOS)    // for iOS
    
    override func draw(_ rect: CGRect) {
        // used to draw the rounded background box and pointer
        if let _ = self.annotation as? CustomAnnotation {
            
            UIColor.darkGray.setFill()
            
            // draw the pointed shape
            let pointShape = UIBezierPath()
            pointShape.move(to: CGPoint(x: 14.0, y: 0.0))
            pointShape.addLine(to: CGPoint(x: 0.0, y: 0.0))
            pointShape.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
            pointShape.fill()
            
            // draw the rounded box
            let roundedRect = UIBezierPath(roundedRect:
                CGRect(x: kRoundBoxLeft,
                    y: 0.0,
                    width: self.frame.size.width - kRoundBoxLeft,
                    height: self.frame.size.height),
                cornerRadius: 3.0)
            roundedRect.lineWidth = 2.0
            roundedRect.fill()
        }
    }
    
    #else   // for OS X
    
    override func drawRect(dirtyRect: NSRect) {
        // used to draw the rounded background box and pointer
        if let _ = self.annotation as? CustomAnnotation {
            NSColor.darkGrayColor().setFill()
            
            // draw the pointed shape
            let pointShape = NSBezierPath()
            pointShape.moveToPoint(CGPointMake(14.0, 0.0))
            pointShape.lineToPoint(CGPointMake(0.0, 0.0))
            pointShape.lineToPoint(CGPointMake(self.frame.size.width, self.frame.size.height))
            pointShape.fill()
            
            // draw the rounded box
            let roundedRect = NSBezierPath(roundedRect:
                CGRectMake(kRoundBoxLeft,
                    0.0,
                    self.frame.size.width - kRoundBoxLeft,
                    self.frame.size.height),
                xRadius: 3.0,
                yRadius: 3.0)
            roundedRect.lineWidth = 2.0
            roundedRect.fill()
        }
    }
    
    #endif
    
}
