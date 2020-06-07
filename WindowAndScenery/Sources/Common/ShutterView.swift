//
//  ShutterView.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/15.
//  Copyright © 2020 xyz.chenms. All rights reserved.
//

import UIKit

class ShutterView: UIView {

    private var layers:[CALayer] = []
    
    init(frame: CGRect, count theCount: Int = 1) {
        super.init(frame: frame)
        var count = theCount
        if theCount <= 0 {
            count = 1
        }
        for _ in 0..<count {
            let layer = obtainLayer()
            layer.backgroundColor = UIColor.white.cgColor
            layers.append(layer)
            self.layer.addSublayer(layer)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = layers.count
        let width = bounds.width / CGFloat(count)
        layers.enumerated().forEach {
            $0.element.frame = CGRect(x: width * CGFloat($0.offset), y: 0, width: width, height: bounds.height)
        }
    }
    
    private func obtainLayer() -> CALayer {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        
        return layer
    }
}

extension ShutterView {
    func startAnimation() {
        layers.forEach {
            $0.removeAllAnimations()
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            $0.opacity = 1
            CATransaction.commit()
        }
        layers.enumerated().forEach {
            let anim = CABasicAnimation(keyPath: "opacity")
            anim.duration = 0.5
            anim.beginTime = $0.element.convertTime(CACurrentMediaTime(), from: nil) + anim.duration * Double($0.offset)
            anim.fromValue = 1
            anim.toValue = 0
            // 由于 layer 的动画用 beginTime 做了延迟
            // 后面代码修改 opacity 的真实值后，layer 开始就会显示（opacity == 0）的状态
            // 所以我们使用 backwards，来保证动画执行前，layer 显示 fromValue（opacity == 1） 的状态
            anim.fillMode = CAMediaTimingFillMode.backwards
            $0.element.add(anim, forKey: nil)
            // 修改 opacity 的真实值，防止动画完成后恢复原样
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            $0.element.opacity = 0
            CATransaction.commit()
        }
    }
    
    func stopAnimation() {
        layers.forEach {
            $0.removeAllAnimations()
            $0.opacity = 1
        }
    }
}
