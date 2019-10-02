//
//  MiniView.swift
//  CurvedParallelView
//
//  Created by HP on 7/2/18.
//  Copyright © 2018 rth. All rights reserved.
//

import UIKit

class MiniView: UIView{
    
    //MARK: - CONSTANTS
    let DEFAULT_HEIGHT_PORTITION : CGFloat = 0.24
    let DEFAULT_CURVED_PORTITION : CGFloat = 0.2
    let DEFAULT_MINI_WIDTH_PORTITION : CGFloat = 0.6
    
    var miniViewWidthPortition: CGFloat?{
        didSet{
            if miniViewWidthPortition == nil{
                miniViewWidthPortition = DEFAULT_MINI_WIDTH_PORTITION
            }else if miniViewWidthPortition! >= 1.0 {
                miniViewWidthPortition = DEFAULT_MINI_WIDTH_PORTITION
            }
            setNeedsDisplay()
        }
    }
    
    var miniViewHeight : CGFloat?{
        didSet{
            if miniViewHeight == nil{
                miniViewHeight = self.frame.height * DEFAULT_HEIGHT_PORTITION
            }else if miniViewHeight! >= self.frame.height {
                miniViewHeight = self.frame.height * DEFAULT_HEIGHT_PORTITION
            }
            setNeedsDisplay()
        }
    }
    
    var curved : CGFloat?{
        didSet{
            if curved == nil{
                curved = self.frame.height * DEFAULT_CURVED_PORTITION
            }else if curved! >= self.frame.height {
                curved = self.frame.height * DEFAULT_CURVED_PORTITION
            }
            setNeedsDisplay()
        }
    }
    
    var miniViewBackgroundColor: UIColor?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawMiniView(rect: rect)
    }
    
    //MARK: - MINI VIEW
    func drawMiniView(rect: CGRect){
        guard let curved = curved else {return}
        guard let miniViewHeight = miniViewHeight else {return}
        guard let miniViewWidthPortition = miniViewWidthPortition else {return}
        let miniViewWidth = miniViewWidthPortition * rect.width
        let miniStartPoint = CGPoint(x: rect.maxX - miniViewWidth, y: rect.minY)
        let topRightPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let topRightControlPoint1 = CGPoint(x: rect.maxX - curved, y: rect.minY)
        let topRightControlPoint2 = CGPoint(x: rect.maxX, y: rect.minY + curved)
        
        let miniPath = UIBezierPath()
        miniPath.move(to: miniStartPoint)
        miniPath.addLine(to: topRightControlPoint1)
        miniPath.addQuadCurve(to: topRightControlPoint2, controlPoint: topRightPoint)
        
        let miniBottomRightPoint = CGPoint(x: rect.maxX, y: rect.minY + miniViewHeight)
        miniPath.addLine(to: miniBottomRightPoint)
        
        let miniBottomLeft = CGPoint(x: rect.maxX - miniViewWidth, y: rect.minY + miniViewHeight)
        let miniBottomLeftControPoint1 = CGPoint(x: rect.maxX - miniViewWidth + curved, y: rect.minY + miniViewHeight)
        let miniBottomLeftControPoint2 = CGPoint(x: rect.maxX - miniViewWidth, y: rect.minY + miniViewHeight - curved)
        
        miniPath.addLine(to: miniBottomLeftControPoint1)
        miniPath.addQuadCurve(to: miniBottomLeftControPoint2, controlPoint: miniBottomLeft)
        miniPath.close()
        
        let miniViewBackgroundColor = self.miniViewBackgroundColor ?? UIColor.black
        miniViewBackgroundColor.setFill()
        miniPath.fill()
    }
}
