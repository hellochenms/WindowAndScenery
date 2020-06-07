//
//  A2LoadingViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A2LoadingViewController: UIViewController {

    private lazy var frontView: GradientView = {
        let view = GradientView()
        view.colors = [.white, .white, .black, .black]
        view.locations = [0, 0.35, 0.65, 1]
        view.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        return view
    }()
    
    private lazy var mask: TriangleLoadingView = {
        let view = TriangleLoadingView()
        
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
        
        // 多窗（3球窗，CAReplicatorLayer 窗）
        mask.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        mask.center = CGPoint(x: frontView.bounds.midX, y: frontView.bounds.midY)
        frontView.mask = mask
        
        // 窗动
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.mask.startAnimation()
        }
    }
}
