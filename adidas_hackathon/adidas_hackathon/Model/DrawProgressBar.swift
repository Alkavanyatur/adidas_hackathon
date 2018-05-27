//
//  DrawProgressBar.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit

class DrawProgressBar: NSObject {
    @objc dynamic public class func drawProgressBar(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 300, height: 14), resizing: ResizingBehavior = .aspectFit, progress: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 335, height: 14), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 300, y: resizedFrame.height / 14)
        
        //// Color Declarations
        let color8 = UIColor(red: 0.129, green: 0.671, blue: 0.647, alpha: 1.000)
        let color5 = UIColor(red: 0.200, green: 0.827, blue: 0.537, alpha: 1.000)
        let color = UIColor(red: 0.086, green: 0.227, blue: 0.373, alpha: 1.000)
        
        
        
        //// Progress border Drawing
        let progressBorderPath = UIBezierPath(roundedRect: CGRect(x: 2, y: 0, width: 297, height: 14), cornerRadius: 7)
        color.setFill()
        progressBorderPath.fill()
        color8.setStroke()
        progressBorderPath.lineWidth = 2
        progressBorderPath.lineCapStyle = .round
        progressBorderPath.stroke()
        
        
        //// Progress Active Drawing
        let progressActivePath = UIBezierPath(roundedRect: CGRect(x: 2, y: 0, width: progress, height: 14), cornerRadius: 7)
        color5.setFill()
        progressActivePath.fill()
        color8.setStroke()
        progressActivePath.lineWidth = 2
        progressActivePath.stroke()
        
    }
    
    @objc(StyleKitNameResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
    
}
