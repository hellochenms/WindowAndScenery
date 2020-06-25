//
//  A3WaveViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A3WaveViewController: UIViewController {
    // MARK: Constants
    private struct Constants {
        static let red = UIColor.m2_hex(0xff2222)
        static let blue = UIColor.m2_hex(0x2299ff)
    }
    
    // MARK: View
    private lazy var bigTopView: WaveView = {
        var view = WaveView()
        view.backgroundColor = .white
        view.waveColor = Constants.red
        
        return view
    }()
    
    private lazy var smallTopView: WaveView = {
        var view = WaveView()
        view.backgroundColor = .black
        view.waveColor = Constants.blue
        
        return view
    }()
    
    private lazy var bigBottomView: WaveView = {
        var view = WaveView()
        view.backgroundColor = .black
        view.waveColor = Constants.blue
        
        return view
    }()
    
    private lazy var smallBottomView: WaveView = {
        var view = WaveView()
        view.backgroundColor = .white
        view.waveColor = Constants.red
        
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
        // 上大半圆 view
        view.addSubview(bigTopView)
        // 上小半圆 view
        view.addSubview(smallTopView)
        // 下大半圆 view
        view.addSubview(bigBottomView)
        // 下小半圆 view
        view.addSubview(smallBottomView)
    }
    
    private func makeLayout() {
        // 设置4个 view 的 mask
        
        // 大上半圆
        let width: CGFloat = 200
        let marginX = (UIScreen.main.bounds.width - width) / 2
        bigTopView.frame = CGRect(x: marginX, y: 200, width: width, height: 200)
        // 大上半圆 mask
        let bigTopMask = HalfCircleView()
        bigTopMask.part = .top
        bigTopMask.frame = CGRect(x: 0, y: 0, width: bigTopView.bounds.width, height: bigTopView.bounds.height / 2)
        bigTopView.mask = bigTopMask
        
        // 小上半圆（半径是大半圆的一半）
        smallTopView.frame = bigTopView.frame
        // 小上半圆 mask
        let smallTopMask = HalfCircleView()
        smallTopMask.part = .top
        smallTopMask.frame = CGRect(x: smallTopView.bounds.width / 4,
                                    y: smallTopView.bounds.height / 4,
                                    width: smallTopView.bounds.width / 2,
                                    height: smallTopView.bounds.height / 4)
        smallTopView.mask = smallTopMask
        
        // 大下半圆
        bigBottomView.frame = bigTopView.frame
        // 大下半圆 mask
        let bigBottomMask = HalfCircleView()
        bigBottomMask.part = .bottom
        bigBottomMask.frame = CGRect(x: 0,
                                     y: bigBottomView.bounds.height / 2,
                                     width: bigBottomView.bounds.width,
                                     height: bigBottomView.bounds.height / 2)
        bigBottomView.mask = bigBottomMask
        
        // 小下半圆
        smallBottomView.frame = bigBottomView.frame
        // 小下半圆 mask
        let smallBottomMask = HalfCircleView()
        smallBottomMask.part = .bottom
        smallBottomMask.frame = CGRect(x: smallBottomView.bounds.width / 4,
                                       y: smallBottomView.bounds.height / 2,
                                       width: smallBottomView.bounds.width / 2,
                                       height: smallBottomView.bounds.height / 4)
        smallBottomView.mask = smallBottomMask
    }
    
    deinit {
        stop()
    }
}

extension A3WaveViewController {
    func start() {
        if let displayLink = displayLink {
            displayLink.invalidate()
            self.displayLink = nil
            progress = 0
        }
        // 启动 CADisplayLink
        let displayLink = CADisplayLink(target: WeakProxy(self), selector: #selector(work))
        displayLink.add(to: RunLoop.current, forMode: .common)
        self.displayLink = displayLink
    }
    
    @objc private func work() {
        if progress < 1 {
            progress += 0.0025
            progress = min(progress, 1)
        } else {
            progress = 0
        }
        // CADisplayLink 回调时，设置4个波浪 view 的 progress
        bigTopView.progress = progress
        bigBottomView.progress = progress
        smallTopView.progress = progress
        smallBottomView.progress = progress
    }
    
    func stop() {
        displayLink?.invalidate()
    }
}
