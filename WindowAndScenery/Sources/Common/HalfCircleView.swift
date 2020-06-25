//
//  HalfCircleView.swift
//  WindowAndScenery
//
//  Created by hellochenms on 2020/5/30.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class HalfCircleView: UIView {
    // MARK: Define
    enum Part {
        // 上半圆
        case top
        // 下半圆
        case bottom
        // 左半圆
        case left
        // 右半圆
        case right
    }
    
    // MARK: Config
    var part: Part = .top
    
    // MARK: Public
    var fillColor: UIColor? {
        didSet {
            (layer as! CAShapeLayer).fillColor = fillColor?.cgColor
        }
    }
    
    // MARK: Life Cycle
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

extension HalfCircleView {
    private func path() -> UIBezierPath {
        var radius: CGFloat = 0
        switch part {
        case .top, .bottom:
            // * 2 这种写法看上去有点傻，但这样可以更好的和画圆类比
            // 当画上半圆或下半圆时，可以类比在 bounds.width（宽）, bounds.height * 2（高） 的框里画整圆
            // 那圆（内切圆）的直径就是 bounds.width, bounds.height * 2 两者中的较小值
            // 那半径就是 radius = floor(min(bounds.width, bounds.height * 2) / 2)
            // 如果你理解了这一点
            // 就可以直接写成 radius = floor(min(bounds.width / 2, bounds.height))
            // 这个写法更加简洁，但乍一看不如上面和整圆对比的直观
            radius = floor(min(bounds.width, bounds.height * 2) / 2)
        case .left, .right:
            radius = floor(min(bounds.width * 2, bounds.height) / 2)
        }
        
        var centerX: CGFloat = 0
        var centerY: CGFloat = 0
        var startAngle: CGFloat = 0
        var endAngle: CGFloat = 0
        // 我们统一按顺时针画，并按 0 到 2π 这个范围，不用负数
        // 因此上半圆是 π 到 2π，而不是逆时针的 0 到 -π
        switch part {
        case .top:
            centerX = bounds.midX
            centerY = bounds.height
            startAngle = CGFloat.pi
            endAngle = CGFloat.pi * 2
        case .bottom:
            centerX = bounds.midX
            centerY = 0
            startAngle = 0
            endAngle = CGFloat.pi
        case .left:
            centerX = bounds.width
            centerY = bounds.midY
            startAngle = CGFloat.pi / 2
            endAngle = CGFloat.pi / 2 * 3
        case .right:
            centerX = 0
            centerY = bounds.midY
            startAngle = CGFloat.pi / 2 * 3
            endAngle = CGFloat.pi / 2
        }
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
}
