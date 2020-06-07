//
//  TriangleLoadingView.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/21.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class TriangleLoadingView: UIView {
    // MARK: Constants
    private struct Constants {
        static let cellRadius: CGFloat = 20.0
    }
    
    // MARK:  Private
    private lazy var cellLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: Constants.cellRadius * 2, height: Constants.cellRadius * 2)
        layer.cornerRadius = Constants.cellRadius
        
        return layer
    }()
    
    // MARK:  Life Cycle
    override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layer = (self.layer as! CAReplicatorLayer)
        layer.backgroundColor = UIColor.clear.cgColor
        layer.instanceCount = 3
        // 3个小球
        // 每个以本 view 的 layer（CAReplicatorLayer）中心为原点，以 z 轴为旋转轴
        // 以上一个 cellLayer 的状态 为初始态，顺时针旋转 120°
        // 形成一个等边三角形
        layer.instanceTransform = CATransform3DMakeRotation(CGFloat.pi / 3 * 2, 0, 0, 1)
        layer.addSublayer(cellLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 第1个小球，在本 view 的顶部，水平居中
        cellLayer.position = CGPoint(x: bounds.midX, y: Constants.cellRadius)
    }
}

extension TriangleLoadingView {
    func startAnimation() {
        cellLayer.removeAllAnimations()
        
        let anim = CABasicAnimation(keyPath: "position")
        let from = cellLayer.position
        anim.fromValue = from
        
        // 使用一点等边三角形的知识
        // r：等边三角形的外径（外接圆的半径）
        let r = bounds.midY -  Constants.cellRadius
        // 根据等边三角形的上顶点的坐标和外径，求右下顶点的坐标
        // radian：30°
        let radian = CGFloat.pi / 6
        anim.toValue = CGPoint(x: from.x + r * cos(radian), y: from.y + r + r * sin(radian))
        anim.duration = 1
        anim.repeatCount = Float.infinity
        cellLayer.add(anim, forKey: nil)
        
        // 注：我们实现了圆窗从上顶点到右下顶点的移动
        // CAReplicatorLayer 就可以根据我们之前设置的 instanceTransform，自动帮我们完成其他两种顶点间的移动
    }
    
    func stopAnimation() {
        cellLayer.removeAllAnimations()
    }
}
