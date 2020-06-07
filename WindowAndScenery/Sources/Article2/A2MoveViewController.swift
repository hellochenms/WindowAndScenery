//
//  A2MoveViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A2MoveViewController: UIViewController {

    private lazy var frontView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "front")
        
        return view
    }()
    
    private lazy var mask: CircleView = {
        let view = CircleView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // 景
        frontView.frame = UIScreen.main.bounds
        view.addSubview(frontView)
        
        // 圆窗
        mask.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        mask.center = CGPoint(x: 100, y: 250)
        frontView.mask = mask
        
        // 窗动
        // 动画地改变 mask 的中心
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.startAnimation()
        }
    }
    
    deinit {
        stopAnimation()
    }
}

extension A2MoveViewController {
    private func startAnimation() {
        mask.layer.removeAllAnimations()
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        let bound = UIScreen.main.bounds
        anim.values = [CGPoint(x: 100, y: 250), CGPoint(x:bound.width - 100 , y: 250), CGPoint(x: bound.midX, y: 450), CGPoint(x: 100, y: 250)]
        anim.duration = 4
        anim.repeatCount = Float.infinity
        mask.layer.add(anim, forKey: nil)
    }
    
    private func stopAnimation() {
        mask.layer.removeAllAnimations()
    }
}
