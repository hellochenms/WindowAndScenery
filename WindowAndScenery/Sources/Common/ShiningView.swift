//
//  ShiningView.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

// 渐变动画 view（看上去像是一道竖着的白光从左向右划过）
class ShiningView: UIView {
    // MARK:  Public
    var gradientLayer: CAGradientLayer {
        return (layer as! CAGradientLayer)
    }
    
    // MARK:  Life Cycle
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layer = (self.layer as! CAGradientLayer)
        let colors: [UIColor] = [.black, .black, .white, .black, .black]
        layer.colors = colors.map { $0.cgColor }
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        layer.locations = [0, 0, 0.05, 0.1, 1]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShiningView {
    func start() {
        layer.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0, 0, 0.05, 0.1, 1]
        animation.toValue = [0, 0.9, 0.95, 1, 1]
        animation.duration = 1.5
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: nil)
    }
    
    func stop() {
        layer.removeAllAnimations()
    }
}
