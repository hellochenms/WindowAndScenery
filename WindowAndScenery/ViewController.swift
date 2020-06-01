//
//  ViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Constants
    private struct Constants {
        static let cellIdentifier: String = "cellIdentifier"
    }
    
    // MARK: Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        return tableView
    }()
    
    // MARK: Datas
    private lazy var datas: [(String, [(String, UIViewController.Type)])] = {
        let datas =
            [("第一篇",
              [("圆窗", A1CircleViewController.self),
               ("圆窗（双图片）", A1Circle2ViewController.self),
               ("文字窗", A1TextViewController.self),
               ("渐变景", A1GradientViewController.self),
               ("文字窗渐变景", A1TextGradientViewController.self),
               ("半透明渐变窗", A1TableViewController.self)])]
        
        return datas as! [(String, [(String, UIViewController.Type)])]
    }()
}

// MARK:  Life Cycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        makeLayout()
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func makeLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK:  UITableViewDataSource & UITableViewDelegate
extension ViewController: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return datas[section].0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = (datas[indexPath.section].1)[indexPath.row].0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vcType = (datas[indexPath.section].1)[indexPath.row].1
        let vc = vcType.init()
        navigationController?.pushViewController(vc, animated: true)
    }
}
