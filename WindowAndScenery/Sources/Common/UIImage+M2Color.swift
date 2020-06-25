//
//  UIImage+M2.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/20.
//  Copyright © 2020 xyz.chenms. All rights reserved.
//

import UIKit

extension UIImage {
    public func m2_grayImage() -> UIImage? {
        let width = size.width
        let height = size.height
        let colorSpace = CGColorSpaceCreateDeviceGray()
        guard let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue)
            else { return nil }
        guard let cgImage = cgImage else { return nil }
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let destCGImage = context.makeImage() else { return nil }
        let image = UIImage(cgImage: destCGImage)
        
        return image
    }
}
