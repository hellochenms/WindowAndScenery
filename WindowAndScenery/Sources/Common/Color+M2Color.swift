//
//  Color+Utils.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

extension UIColor {
    // 输入类似 0x99ccff 这样的值
    static func m2_hex(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor? {
        let r = (hex >> 16) & 0xff
        let g = (hex >> 8) & 0xff
        let b = hex & 0xff
        guard r >= 0, r <= 255, g >= 0, g <= 255, b >= 0, b <= 255 else { return nil }
        var a: CGFloat = 0
        if alpha >= 0, alpha <= 1 {
            a = alpha
        } else {
            a = 1.0
        }
        let color = self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
        
        return color
    }
}

extension UIColor {
    // 随机颜色
    public static func m2_random(_ alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        var a: CGFloat = 0
        if alpha >= 0, alpha <= 1 {
            a = alpha
        } else {
            a = 1.0
        }
        let color = UIColor(red: r, green: g, blue: b, alpha: a)
        
        return color
    }
}
