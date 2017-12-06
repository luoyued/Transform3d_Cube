//
//  CubeFaceView.swift
//  03core  Anmiation mask
//
//  Created by wang dan on 2017/12/6.
//  Copyright © 2017年 luoyue. All rights reserved.
//

import UIKit

class LYCubeFaceView: UIView {

    
    
    init(frame: CGRect,text:String) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255.0, green:  CGFloat(arc4random()%255)/255.0, blue:  CGFloat(arc4random()%255)/255.0, alpha: 1)
        let label = UILabel(frame: bounds)
        label.text = text

        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        self.addSubview(label)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
