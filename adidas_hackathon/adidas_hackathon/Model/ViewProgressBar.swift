//
//  ViewProgressBar.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit

class ViewProgressBar: UIView {
    
    private var _innerProgress: CGFloat = 0.0
    
    var progress:CGFloat{
        set(newProgress) {
            if(newProgress > 1.0){
                _innerProgress = 1.0
            }else if(newProgress < 0.0){
                _innerProgress = 0.0
            }else{
                _innerProgress = newProgress
            }
            setNeedsDisplay()
        }
        get{
            return _innerProgress * 297
        }
    }
    
    override func draw(_ rect: CGRect) {
        //drawProgressBar(frame: bounds, progress: progress)
        progress = 0.75
        DrawProgressBar.drawProgressBar(frame: bounds, resizing: .aspectFit, progress: progress)
        //ProgressBarDraw.drawProgressBar(frame: bounds, progress: progress)
    }
    
}
