//
//  CheckTableViewController.swift
//  CheckBox
//
//  Created by 周泽勇 on 15/8/11.
//  Copyright (c) 2015年 周泽勇. All rights reserved.
//

import UIKit

private let CheckTableViewCellIdentifier = "CheckTableViewCellIdentifier"

public class CheckTableViewController: UIViewController, UITableViewDelegate {
    public var tableView:UITableView = UITableView(frame: CGRectZero)
    
    public var options:[String] = []
    private var dataSource:CheckTableViewDataSource!


    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.bottom.equalTo(self.view)
            if let topLayoutGuide = self.topLayoutGuide as? UIView {
                make.top.equalTo(topLayoutGuide.snp_bottom)
            }
        }
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.delegate = self
        tableView.registerClass(CheckTableViewCell.self, forCellReuseIdentifier: CheckTableViewCellIdentifier)
        
        dataSource = CheckTableViewDataSource(options: self.options)
        tableView.dataSource = dataSource
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

public class CheckTableViewDataSource:NSObject, UITableViewDataSource {
    private var options:[String] = []
    
    public init(options:[String]) {
        self.options = options
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(CheckTableViewCellIdentifier) as! CheckTableViewCell
        cell.checkbox.text = options[indexPath.row]
        cell.checkbox.checkboxAlignment = UICheckboxAlignment.Right
        return cell
    }
}

public class CheckTableViewCell:UITableViewCell {
    public var checkbox:UICheckbox = UICheckbox(frame: CGRectZero)
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCheckTableCell()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCheckTableCell()
    }
    
    private func setupCheckTableCell() {
        contentView.addSubview(checkbox)
        checkbox.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self.contentView).offset(10)
            make.trailing.equalTo(self.contentView).offset(-10)
            make.top.bottom.equalTo(self.contentView)
        }
    }
}
