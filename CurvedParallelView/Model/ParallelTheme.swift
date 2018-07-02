//
//  ColorTheme.swift
//  CurvedParallelView
//
//  Created by HP on 6/29/18.
//  Copyright © 2018 rth. All rights reserved.
//

import UIKit
struct ParallelTheme{
    let miniViewWidthPortition: CGFloat?
    let curved: CGFloat?
    let imageBackground: UIImage?
    let miniViewContent : String?
    let miniViewHeight : CGFloat?
    let miniViewBackgroundColor: UIColor?
    let fillBackgroundColor: UIColor?
    let miniViewContentColor: UIColor?
    
    init(fillBackgroundColor: UIColor?, curved: CGFloat?, imageBackground: UIImage?, miniViewWidthPortition: CGFloat?, miniViewHeight: CGFloat?, miniViewContent: String?, miniViewBackgroundColor: UIColor?, miniViewContentColor: UIColor?) {
        self.miniViewWidthPortition = miniViewWidthPortition
        self.curved = curved
        self.imageBackground = imageBackground
        self.miniViewHeight = miniViewHeight
        self.miniViewContent = miniViewContent
        self.miniViewBackgroundColor = miniViewBackgroundColor
        self.fillBackgroundColor = fillBackgroundColor
        self.miniViewContentColor = miniViewContentColor
    }
    
    func getColorPalatte() -> [String]{
        var colors: [String] = []
        colors.append(self.miniViewBackgroundColor?.hexString ?? "No Color")
        colors.append(self.miniViewContentColor?.hexString ?? "No Color")
        colors.append(self.fillBackgroundColor?.hexString ?? "No Color")
        return colors
    }
}

