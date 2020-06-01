//
//  CircleView.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/6.
//  Copyright © 2020 xyz.chenms. All rights reserved.
//

import UIKit

// 圆
class CircleView: UIView {
    // MARK:  Public
    var fillColor: UIColor? {
        didSet {
            (layer as! CAShapeLayer).fillColor = fillColor?.cgColor
        }
    }
    
    // MARK:  Life Cycle
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        (layer as! CAShapeLayer).fillColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        (layer as! CAShapeLayer).path = path().cgPath
    }
}

extension CircleView {
    private func path() -> UIBezierPath {
        // 用宽和高中较小的来决定半径
        let radius = floor(min(bounds.width / 2, bounds.height / 2))
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: 0, endAngle: CGFloat(Float.pi) * 2.0, clockwise: true)
        
        return path
    }
}
