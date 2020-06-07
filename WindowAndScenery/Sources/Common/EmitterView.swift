//
//  EmitterView.swift
//  WindowAndScenery
//
//  Created by hellochenms on 2020/5/26.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class EmitterView: UIView {
    // MARK:  Life Cycle
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
extension EmitterView {
    private func configLayer() {
        // 心形粒子
        let cell = CAEmitterCell()
        // 样式
        cell.contents = UIImage(named: "love")?.cgImage
        cell.scale = 0.5
        cell.scaleSpeed = 2
        // 产生粒子的速率
        cell.birthRate = 20
        // 存活时长
        cell.lifetime = 3
        // 方向
        cell.emissionLongitude = CGFloat(Float.pi / 2)
        cell.emissionRange = CGFloat.pi / 3
        // 速度
        cell.velocity = -250
        cell.velocityRange = 50

        // 发射器
        let emitterLayer = (layer as! CAEmitterLayer)
        emitterLayer.emitterPosition = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.height)
        emitterLayer.birthRate = 1
        emitterLayer.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.point
        emitterLayer.emitterCells = [cell]
    }
}
