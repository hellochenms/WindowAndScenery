//
//  RingView.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/20.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class RingView: UIView {
    // MARK:  Public
    var progress: CGFloat = 0 {
        didSet {
            if progress < 0 {
                progress = 0
            } else if progress > 1 {
                progress = 1
            } else {}
            
            (layer as! CAShapeLayer).strokeEnd = progress
        }
    }

    // MARK:  Life Cycle
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let layer = (self.layer as! CAShapeLayer)
        layer.fillColor = nil
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 20.0
        layer.path = path().cgPath
        layer.strokeEnd = 0
        // 路径（环）的端点设置为圆角
        layer.lineCap = .round
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        (layer as! CAShapeLayer).path = path().cgPath
    }
}

extension RingView {
    private func path() -> UIBezierPath {
        let radius = floor(min(bounds.width / 2, bounds.height / 2))
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: -CGFloat(Float.pi / 2), endAngle: CGFloat(Float.pi / 2) * 3.0, clockwise: true)
        
        return path
    }
}
