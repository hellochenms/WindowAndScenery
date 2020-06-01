//
//  A1TextGradientViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A1TextGradientViewController: UIViewController {

    private lazy var frontView: ShiningView = {
        let view = ShiningView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.m2_hex(0x99ccff)
        
        // 渐变动画景
        frontView.frame = UIScreen.main.bounds
        view.addSubview(frontView)
        // 执行动画
        frontView.start()
        
        // 文字窗
        let mask = UIButton(type: .custom)
        mask.setTitle("柯烂", for: .normal)
        mask.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        mask.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        mask.center = CGPoint(x: frontView.bounds.midX, y: frontView.bounds.midY)
        frontView.mask = mask
    }
    
    deinit {
        frontView.stop()
    }

}
