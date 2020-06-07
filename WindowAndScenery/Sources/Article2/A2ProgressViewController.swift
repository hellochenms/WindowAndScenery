//
//  A2ProgressViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A2ProgressViewController: UIViewController {

    private lazy var frontView: GradientView = {
        let view = GradientView()
        view.colors = [.white, .white, .black, .black]
        view.locations = [0, 0.35, 0.65, 1]
        view.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        return view
    }()
    
    private lazy var mask: RingView = {
        let view = RingView()
        
        return view
    }()
    
    private var progress: CGFloat = 0
    private var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.m2_hex(0x99ccff)
        
        // 渐变景
        frontView.frame = UIScreen.main.bounds
        view.addSubview(frontView)
        
        // 环窗
        mask.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        mask.center = CGPoint(x: frontView.bounds.midX, y: frontView.bounds.midY)
        frontView.mask = mask
        
        // 窗变
        // 动画地改变 mask 圆环的完成度（从圆环未开始，到圆环完全闭合）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.startAnimation()
        }
    }
    
    deinit {
        stopAnimation()
    }
}

extension A2ProgressViewController {
    private func startAnimation() {
        displayLink?.invalidate()
        
        progress = 0
        let displayLink = CADisplayLink(target: WeakProxy(self), selector: #selector(onTik))
        displayLink.add(to: RunLoop.main, forMode: .common)
        self.displayLink = displayLink
    }
    
    @objc private func onTik() {
        progress += 1.0 / 60 / 3
        if progress > 1 {
            progress = 0
        }
        mask.progress = progress
    }
    
    private func stopAnimation() {
        displayLink?.invalidate()
    }
}
