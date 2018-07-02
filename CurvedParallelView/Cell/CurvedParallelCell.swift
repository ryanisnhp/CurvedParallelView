//
//  CurvedParallelCell.swift
//  CurvedParallelView
//
//  Created by HP on 6/29/18.
//  Copyright © 2018 rth. All rights reserved.
//

import UIKit
protocol OnTapButtonDelegate : class{
    func onTapButton(cell: CurvedParallelCell)
}

class CurvedParallelCell: UITableViewCell {

    lazy var curvedParallelView = ThumbView()
    lazy var viewFrame = CGRect()
    weak var delegate: OnTapButtonDelegate?
    
    var theme: ParallelTheme!{
        didSet{
            curvedParallelView.dropTheme(theme: theme)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenWidth = UIScreen.main.bounds.size.width
        let margin : CGFloat = 10.0
        viewFrame = CGRect(x: margin, y: 0.0, width: screenWidth - 2 * margin, height: 220.0)
        curvedParallelView = ThumbView(frame: viewFrame)
        curvedParallelView.backgroundColor = .clear
        curvedParallelView.delegate = self
        self.addSubview(curvedParallelView)
    }
}

extension CurvedParallelCell: InfoButtonDelegate{
    func onGetInfo() {
        delegate?.onTapButton(cell: self)
    }
}
