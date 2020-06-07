//
//  A2ChangeViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A2ChangeViewController: UIViewController {

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
    
    private lazy var mask: CircleView = {
        let view = CircleView()
        
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
        
        // 圆窗
        mask.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        mask.center = CGPoint(x: frontView.bounds.midX, y: frontView.bounds.midY)
        frontView.mask = mask
        
        // 窗变
        // 动画地改变 mask 的大小
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.startAnimation()
        }
    }
    
    deinit {
        stopAnimation()
    }
}

extension A2ChangeViewController {
    private func startAnimation() {
        mask.layer.removeAllAnimations()
        
        let scale: CGFloat = 5.0
        let anim = CABasicAnimation(keyPath: "transform.scale.xy")
        anim.fromValue = 1.0
        anim.toValue = scale
        anim.duration = 1
        mask.layer.add(anim, forKey: nil)
        
        // 真正改变 layer 的 transform，防止动画结束后恢复原状
        mask.layer.transform = CATransform3DMakeScale(scale, scale, 1)
    }
    
    private func stopAnimation() {
        mask.layer.removeAllAnimations()
    }
}
