//
//  A1GradientViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A1GradientViewController: UIViewController {

    // 渐变动画景
    private lazy var frontView: ShiningView = {
        let view = ShiningView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ***彩蛋***
        // 简单易记的配色法
        // 从 69cf（6+3=9，9+3=c，c+3=f，以3递增）里随便4选3，分别作为RGB值
        // 比如本例选了9cf，形成 0x99ccff 这种蓝色
        // 69cf法不一定多好看，胜在好记
        // 当你厌倦了使用系统 .red、.blue 等作为 demo 的临时色值时，可以试试 69cf 法
        view.backgroundColor = UIColor.m2_hex(0x99ccff)
        
        // 渐变动画景
        frontView.frame = UIScreen.main.bounds
        view.addSubview(frontView)
        // 执行动画
        frontView.start()
        
        // 圆窗
        let mask = CircleView()
        mask.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        mask.center = CGPoint(x: frontView.bounds.midX, y: frontView.bounds.midY)
        frontView.mask = mask
    }
    
    deinit {
        frontView.stop()
    }

}
