//
//  A1TableViewController.swift
//  WindowAndScenery
//
//  Created by Chen,Meisong on 2020/5/19.
//  Copyright © 2020 hellochenms. All rights reserved.
//

import UIKit

class A1TableViewController: UIViewController {
    // MARK: Constants
    private struct Constants {
        static let cellIdentifier: String = "cellIdentifier"
    }
    
    // 模拟多条聊天数据
    private lazy var datas: [String] = {
        let datas = Array(repeating: 0, count: 30).enumerated().map { _ in "\(randomText())" }
        
        return datas
    }()
    
    // 每条聊天数据由随机组个“XXXXX”组成
    private func randomText() -> String {
        var text = ""
        for _ in 1...Int.random(in: 1...5) {
            text += "XXXXX"
        }
        
        return text
    }
    
    // 聊天 table
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(A1Cell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        return tableView
    }()
    
    // MARK:  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.contentMode = .scaleAspectFill
        view.layer.contents = UIImage(named: "front")?.cgImage
        view.layer.masksToBounds = true

        // table 景（tableContainer 来辅助，和 table 尺寸相同）
        let tableContainer = UIView()
        let bounds = UIScreen.main.bounds
        let gradientHeight: CGFloat = 20.0
        tableContainer.frame = CGRect(x: 0, y: bounds.midY, width: bounds.width / 2, height: bounds.height / 2)
        view.addSubview(tableContainer)
        tableView.frame = tableContainer.bounds
        tableContainer.addSubview(tableView)
    
        // 半透明渐变窗
        let mask = GradientView()
        mask.frame = tableContainer.bounds
        // 从下
        mask.gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        // 向上渐变
        mask.gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        // mask 大部分是有颜色的（对应着窗透明），最顶上的一小部分渐变为透明（对应着窗渐变为不透明）
        mask.colors = [.white, .white, UIColor.white.withAlphaComponent(0)]
        mask.locations = [0, 1 - Double(gradientHeight / tableContainer.bounds.height), 1]
        // 作为 tableContainer 的 mask，而不是 tableView
        tableContainer.mask = mask
    }
}

// MARK:  UITableViewDataSource & UITableViewDelegate
extension A1TableViewController: UITableViewDataSource & UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let title = datas[indexPath.row]
        
        return A1Cell.cellHeight(title, maxWidth: tableView.bounds.width)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! A1Cell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configData(datas[indexPath.row])
        
        return cell
    }
}

// 聊天 Cell
class A1Cell: UITableViewCell {
    // MARK: Constants
    private struct Constants {
        static let cellXPadding: CGFloat = 10
        static let cellYPadding: CGFloat = 5
        static let bgXPadding: CGFloat = 10
        static let bgYPadding: CGFloat = 5
    }
    
    // MARK: View
    private lazy var bg: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = A1Cell.labelFont()
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    

    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bg)
        bg.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension A1Cell {
    // 计算尺寸
    private static func cellSize(_ title: String, maxWidth: CGFloat) -> CGSize {
        let size = (title as NSString).boundingRect(with: CGSize(width: maxWidth - Constants.cellXPadding * 2 - Constants.bgXPadding * 2, height: CGFloat.infinity), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: labelFont()], context: nil).size
        
        return size
    }
    
    // 计算行高
    static func cellHeight(_ title: String, maxWidth: CGFloat) -> CGFloat {
        var height = ceil(cellSize(title, maxWidth: maxWidth).height)
        height += (Constants.cellYPadding * 2 + Constants.bgYPadding * 2)
        
        return height
    }
    
    // 配置 Cell
    func configData(_ title: String) {
        label.text = title
        let size = A1Cell.cellSize(title, maxWidth: contentView.bounds.width)
        bg.frame = CGRect(x: Constants.cellXPadding, y: 10, width: size.width + Constants.bgXPadding * 2, height: size.height + Constants.bgYPadding * 2)
        label.frame = CGRect(x: Constants.bgXPadding, y: Constants.bgYPadding, width: size.width, height: size.height)
    }
}

// 样式
extension A1Cell {
    static func labelFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
}
