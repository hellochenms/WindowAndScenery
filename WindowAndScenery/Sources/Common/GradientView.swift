//
//  GradientView.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/7.
//  Copyright © 2020 xyz.chenms. All rights reserved.
//

import UIKit

class GradientView: UIView {
    // MARK:  Public
    var gradientLayer: CAGradientLayer {
        return (layer as! CAGradientLayer)
    }
    
    // 只是语法糖，外部可以取 gradientLayer 自己设置
    var locations: [Double] = [] {
        didSet {
            (layer as! CAGradientLayer).locations = locations.map { NSNumber(floatLiteral: $0) }
        }
    }
    
    var colors: [UIColor]? {
        didSet {
            guard let colors = colors else { return }
            (layer as! CAGradientLayer).colors = colors.compactMap { $0.cgColor}
        }
    }
    
    // MARK:  Life Cycle
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
