//
//  A1CircleMaskViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A1CircleViewController: UIViewController {

    // 景（图片）
    private lazy var frontView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "front")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // 图片景
        frontView.frame = UIScreen.main.bounds
        view.addSubview(frontView)
        
        // 圆窗
        let mask = CircleView()
        mask.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        mask.center = CGPoint(x: frontView.bounds.midX, y: frontView.bounds.midY)
        frontView.mask = mask
    }
}
