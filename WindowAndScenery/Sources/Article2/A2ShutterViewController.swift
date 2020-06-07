//
//  A2ShutterViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A2ShutterViewController: UIViewController {
    private lazy var backView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "back")
        
        return view
    }()
    
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
        
        // back view
        backView.frame = UIScreen.main.bounds
        view.addSubview(backView)
        
        // 景
        frontView.frame = UIScreen.main.bounds
        view.addSubview(frontView)
        
        // 百叶窗
        let mask = ShutterView(frame: frontView.bounds, count: 6)
        frontView.mask = mask
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            mask.startAnimation()
        }
    }
}
