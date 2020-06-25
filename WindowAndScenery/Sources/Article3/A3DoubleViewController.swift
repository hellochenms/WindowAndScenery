//
//  A3DoubleViewController.swift
//  WindowAndScenery
//
//  Created by hellochenms on 2020/6/25.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

// 双波浪
class A3DoubleViewController: UIViewController {
    // MARK: Constants
    private struct Constants {
        static let darkBlue = UIColor.m2_hex(0x2255ff)
        static let blue = UIColor.m2_hex(0x2299ff)
    }
    
    // MARK: View
    private lazy var backView: WaveView = {
        var view = WaveView()
        view.backgroundColor = .clear
        view.waveColor = Constants.darkBlue
        
        return view
    }()
    
    private lazy var frontView: WaveView = {
        var view = WaveView()
        view.phiModifier = 1 // 调整初相，防止和另一个波浪完全重合
        view.backgroundColor = .clear
        view.waveColor = Constants.blue
        
        return view
    }()
    
    private var displayLink: CADisplayLink?
    private var progress:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.m2_hex(0x414141)

        addSubViews()
        makeLayout()
        
        // 动画
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.start()
        }
    }
    
    private func addSubViews() {
        view.addSubview(backView)
        view.addSubview(frontView)
    }
    
    private func makeLayout() {
        // back
        let width: CGFloat = 200
        let marginX = (UIScreen.main.bounds.width - width) / 2
        backView.frame = CGRect(x: marginX, y: 200, width: width, height: 200)
        let backMask = CircleView()
        backMask.frame = backView.bounds
        backView.mask = backMask
        
        // front
        frontView.frame = backView.frame
        let frontMask = CircleView()
        frontMask.frame = frontView.bounds
        frontView.mask = frontMask
    }
    
    deinit {
        stop()
    }
}

extension A3DoubleViewController {
    func start() {
        if let displayLink = displayLink {
            displayLink.invalidate()
            self.displayLink = nil
            progress = 0
        } else {
            let displayLink = CADisplayLink(target: WeakProxy(self), selector: #selector(work))
            displayLink.add(to: RunLoop.current, forMode: .common)
            self.displayLink = displayLink
        }
    }
    
    @objc private func work() {
        if progress < 1 {
            progress += 0.0025
            progress = min(progress, 1)
        } else {
            progress = 0
        }
        backView.progress = progress
        frontView.progress = progress
    }
    
    func stop() {
        displayLink?.invalidate()
    }
}
