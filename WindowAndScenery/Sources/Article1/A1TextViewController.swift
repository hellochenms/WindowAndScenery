//
//  A1TextViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A1TextViewController: UIViewController {

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
        
        // 文字窗
        let mask = UIButton(type: .custom)
        mask.setTitle("柯烂", for: .normal)
        mask.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        mask.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        mask.center = CGPoint(x: frontView.bounds.midX, y: frontView.bounds.midY)
        frontView.mask = mask
    }
}
