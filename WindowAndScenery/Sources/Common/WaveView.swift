//
//  WaveView.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/20.
//  Copyright © 2020 xyz.chenms. All rights reserved.
//

import UIKit

class WaveView: UIView {
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let myLayer = (layer as! CAShapeLayer)
        myLayer.fillColor = UIColor.blue.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var waveColor: UIColor? = .blue {
        didSet {
            guard let waveColor = waveColor else { return }
            (layer as! CAShapeLayer).fillColor = waveColor.cgColor
        }
    }
    
    // 调整初相（单位是周期）
    public var phiModifier: Int = 0
    
    public var progress: CGFloat = 0 {
        didSet {
            CATransaction.begin()
            CATransaction.disableActions()
            (layer as! CAShapeLayer).path = path(progress).cgPath
            CATransaction.commit()
        }
    }
    
    private func path(_ progress: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.maxY))
        // 根据正弦公式 y = A * sin(ωx + φ) + k
        var x: CGFloat = 0
        var y: CGFloat = 0
        // 振幅（公式中的 A）
        let amplitud: CGFloat = 10
        for i in 0...Int(ceil(bounds.width)) {
            // x 的值视为时间（1个点为1秒）更容易理解
            x = CGFloat(i)
            // 1个周期是 2pi
            let _2pi = 2 * CGFloat(Float.pi)
            // 角频率（公式中的 ω），
            let w = _2pi / bounds.width
            let wx = w * x
            // 设置初相
            // 外部可以设置 phiModifier 来让影响初相 ，单位是周期
            let count: Int = 8 + phiModifier // 8个周期
            let total = _2pi * CGFloat(count)
            // 初相（公式中的 φ），可以认为正弦曲线波形的 x 轴上初始位置
            // 比如双波浪可以使用不同的初相，然后组合在一起
            let phi: CGFloat = total * progress
            // 偏距（公式中的 k）
            let k = (bounds.height + amplitud) * progress
            // 套用公式
            y = amplitud * sin(wx + phi) + k
            // 上面都是思路按左手坐标系（拇指x食指y中指z，也就是原点在左下）
            // 由于 UIKit 是右手（TODO）（也就是原点在左上）
            // 所以上面算出来的图形是倒立的，图形底部贴着 view 顶部的
            // 所以做一个合适的翻转
            y = y * -1 + bounds.height
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        return path
    }

}
