//
//  A2HeartViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A2HeartViewController: UIViewController {

    private lazy var backView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "front")
        
        return view
    }()
    
    private lazy var frontView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "Audrey")
        
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
        
        // 粒子窗
        let mask = EmitterView()
        mask.frame = frontView.bounds
        frontView.mask = mask
    }
}
