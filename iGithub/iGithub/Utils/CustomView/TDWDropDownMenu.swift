//
//  TDWDropDownMenu.swift
//  TDWDropDownMenu
//
//  Created by yfm on 2018/10/9.
//  Copyright © 2018年 com.yfm.www. All rights reserved.
//

import UIKit

class TDWDropDownMenu: UIView {

    var callBack: ((String) -> Void)?

    /// instace variable
    internal var itemHeight: CGFloat = 30.0
    internal var menuHeight: CGFloat = 200.0
    private var viewFrame: CGRect = .zero
    private let cellIdentify = "ItemCell"
    private var datasource: [String] = [String]()

    public var menuBackgroundColor: UIColor = .clear {
        didSet {
            tableView.backgroundColor = menuBackgroundColor
        }
    }

    /// class variable
    static let window = UIApplication.shared.keyWindow

    /// lazy load
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentify)
        view.delegate = self
        view.dataSource = self
        view.tableFooterView = UIView()
        view.layer.cornerRadius = 2
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = UIColor(valueRGB: 0xf2f2f2)
        return view
    }()

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: - public method
    @discardableResult
    static func show(frame: CGRect,
                     data: [String],
                     callBack: @escaping (String) -> Void) -> TDWDropDownMenu {
        let menu = self.init(frame: UIScreen.main.bounds)
        menu.show(frame: frame, data: data, callBack: callBack)
        return menu
    }

    static func hide() {
        let menu = self.getMenuView()
        menu?.hide()
    }

    // MARK: - private method
    private func show(frame: CGRect,
                      data: [String],
                      callBack: @escaping (String) -> Void) {
        self.viewFrame = frame
        self.callBack = callBack
        self.datasource = data

        TDWDropDownMenu.window?.addSubview(self)
        self.addSubview(self.backgroundView)
        self.addSubview(self.tableView)

        self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.size.height, width: frame.size.width, height: 0)

        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: {
                        self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.size.height, width: frame.size.width, height: self.menuHeight)
                        self.tableView.reloadData()
        }) { (_) in

        }
    }

    private func hide() {
        let frame = self.viewFrame

        UIView.animate(withDuration: 0.15,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: {
                        self.tableView.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.size.height, width: frame.size.width, height: 0)
        }) { (_) in
            self.tableView.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }

    private static func getMenuView() -> TDWDropDownMenu? {
        if let subViews = window?.subviews.reversed() {
            for view in subViews where view is TDWDropDownMenu {
                return view as? TDWDropDownMenu
            }
        }
        return nil
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let localPoint = touch.location(in: backgroundView)
            if backgroundView.frame.contains(localPoint) {
                TDWDropDownMenu.hide()
            }
        }
    }

}

extension TDWDropDownMenu: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify, for: indexPath)
        cell.textLabel?.text = self.datasource[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let block = self.callBack {
            block(self.datasource[indexPath.row])
        }

        self.hide()
    }
}
