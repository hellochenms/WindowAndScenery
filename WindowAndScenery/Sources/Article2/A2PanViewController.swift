//
//  A2PanViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A2PanViewController: UIViewController {

    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.text = "请在屏幕上，随意滑动手指"
        
        return label
    }()
    
    private lazy var frontView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "front")
        
        view.isUserInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(pan)
        
        return view
    }()
    
    private lazy var mask: CircleView = {
        let view = CircleView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // 提示
        tipsLabel.frame = view.bounds
        view.addSubview(tipsLabel)
        
        // 景
        frontView.frame = UIScreen.main.bounds
        view.addSubview(frontView)
        
        // 圆窗
        frontView.mask = mask
    }
}

extension A2PanViewController {
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .began:
            // 拖动开始，显示窗
            mask.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            mask.center = pan.location(in: pan.view)
        case .changed:
            // 拖动过程，移动窗
            mask.center = pan.location(in: pan.view)
        default:
            // 其他，隐藏窗
            mask.frame = CGRect.zero
        }
    }
}
