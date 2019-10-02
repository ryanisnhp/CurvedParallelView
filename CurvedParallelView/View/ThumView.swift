//
//  ThumView.swift
//  CurvedParallelView
//
//  Created by HP on 6/29/18.
//  Copyright © 2018 rth. All rights reserved.
//

import UIKit

protocol InfoButtonDelegate: class{
    func onGetInfo()
}
class ThumbView: UIView{
    
    let DEFAULT_HEIGHT_PORTITION : CGFloat = 0.24
    let DEFAULT_CURVED_PORTITION : CGFloat = 0.2
    let DEFAULT_MINI_WIDTH_PORTITION : CGFloat = 0.6
    
    // MARK: - MAIN VIEW
    var fillBackgroundColor: UIColor?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    var image: UIImage?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    // MARK: MINI VIEW
    lazy var miniView = MiniView()
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
    
    var miniViewContent : String?{
        didSet{
            setNeedsDisplay()
            miniLabel.setNeedsDisplay()
        }
    }
    
    var miniViewBackgroundColor: UIColor?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    //MARK: - LABEL
    lazy var miniLabel = UILabel()
    
    var labelFrame: CGRect?{
        didSet{
            miniLabel.setNeedsDisplay()
            setNeedsDisplay()
        }
    }
    
    var miniViewContentColor: UIColor?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    var miniViewContentFont: UIFont?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let curved = curved else {return}
        let path = UIBezierPath()
        let topLeftPoint = CGPoint(x: rect.minX, y: rect.minY)
        let topLeftPointControlPoint1 = CGPoint(x: rect.minX, y: rect.minY + curved)
        let topLeftPointControlPoint2 = CGPoint(x: rect.minX + curved, y: rect.minY)
        
        let topRightPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let topRightControlPoint1 = CGPoint(x: rect.maxX - curved, y: rect.minY)
        let topRightControlPoint2 = CGPoint(x: rect.maxX, y: rect.minY + curved)
        
        let bottomRightPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomRightCopntrolPoint1 = CGPoint(x: rect.maxX, y: rect.maxY - curved)
        let bottomRightCopntrolPoint2 = CGPoint(x: rect.maxX - curved, y: rect.maxY)

        let bottomLeftPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomLeftPointControlPoint1 = CGPoint(x: rect.minX + curved, y: rect.maxY)
        let bottomLeftPointControlPoint2 = CGPoint(x: rect.minX, y: rect.maxY - curved)
        
        
        path.move(to: topLeftPointControlPoint1)
        path.addQuadCurve(to: topLeftPointControlPoint2, controlPoint: topLeftPoint)
        path.addLine(to: topRightControlPoint1)
        path.addQuadCurve(to: topRightControlPoint2, controlPoint: topRightPoint)
        path.addLine(to: bottomRightCopntrolPoint1)
        path.addQuadCurve(to: bottomRightCopntrolPoint2, controlPoint: bottomRightPoint)
        path.addLine(to: bottomLeftPointControlPoint1)
        path.addQuadCurve(to: bottomLeftPointControlPoint2, controlPoint: bottomLeftPoint)
        path.close()
        
        let fillColor = fillBackgroundColor ?? UIColor.cyan
        fillColor.setFill()
        path.fill()
        
        if let backgroundImage = image{
            let imageRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
            let imageView = UIImageView(frame: imageRect)
            imageView.image = backgroundImage
            imageView.contentMode = .scaleAspectFill
            self.addSubview(imageView)
        }
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 0.0
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    
        drawMiniView(rect: rect, curved: curved, miniBackgroundColor: miniViewBackgroundColor, miniViewHeight: miniViewHeight, miniViewWidthPortition: miniViewWidthPortition)
        drawInfoButton(rect: rect)
        drawLabel(rect: rect)
    }
    
    //MARK: MINI VIEW
    func drawMiniView(rect: CGRect, curved: CGFloat?, miniBackgroundColor: UIColor?, miniViewHeight: CGFloat?, miniViewWidthPortition: CGFloat?){
        miniView = MiniView(frame: rect)
        miniView.backgroundColor = .clear
        miniView.curved = curved
        miniView.miniViewBackgroundColor = miniBackgroundColor
        miniView.miniViewHeight = miniViewHeight
        miniView.miniViewWidthPortition = miniViewWidthPortition
        self.addSubview(miniView)
    }
    
    func drawLabel(rect: CGRect){
        guard let miniViewHeight = miniViewHeight else { return }
        guard let miniViewWidthPortition = miniViewWidthPortition else {return}
        miniLabel.removeFromSuperview()
        
        let miniContentFont = miniViewContentFont ?? UIFont.systemFont(ofSize: 24.0, weight: .bold)
        
        let miniViewWidth = miniViewWidthPortition * self.frame.width
        labelFrame = CGRect(x: rect.maxX - miniViewWidth, y: rect.minY, width: miniViewWidth, height: miniViewHeight)
        miniLabel = UILabel(frame: labelFrame!)
        miniLabel.font = miniContentFont
        miniLabel.textColor = miniViewContentColor ?? .white
        miniLabel.text = miniViewContent
        miniLabel.textAlignment = .center
        
        miniLabel.sizeToFit()
        let resizeWidth = miniLabel.frame.width
        let labelPadding = curved
        miniLabel.frame = CGRect(x: rect.maxX - resizeWidth - labelPadding!, y: rect.minY, width: resizeWidth + labelPadding!, height: miniViewHeight)
        miniLabel.setNeedsDisplay()
        self.addSubview(miniLabel)
        miniView.miniViewWidthPortition = (resizeWidth + labelPadding!) / (self.frame.width)
        miniView.setNeedsDisplay()
    }
    
    weak var delegate: InfoButtonDelegate?
    
    func drawInfoButton(rect: CGRect){
        let buttonHeight : CGFloat = 50.0
        let buttonRect = CGRect(x: 0.0, y: rect.height - buttonHeight, width: buttonHeight, height: buttonHeight)
        let infoButton = UIButton(frame: buttonRect)
        infoButton.setImage(UIImage(named: "ic_info"), for: .normal)
        infoButton.addTarget(self, action: #selector(onTapInfo), for: .touchUpInside)
        self.addSubview(infoButton)
    }
    
    @objc func onTapInfo(){
        delegate?.onGetInfo()
    }
    
    func dropTheme(theme: ParallelTheme){
        self.miniViewWidthPortition = theme.miniViewWidthPortition
        self.curved = theme.curved
        self.miniViewHeight = theme.miniViewHeight
        self.miniViewContent = theme.miniViewContent
        self.miniViewBackgroundColor = theme.miniViewBackgroundColor
        self.fillBackgroundColor = theme.fillBackgroundColor
        self.miniViewContentColor = theme.miniViewContentColor
        self.image = theme.imageBackground
        setNeedsDisplay()
    }
}
