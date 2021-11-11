//
//  ATTableDemoViewController.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

class ATTableDemoViewController: UIViewController {

    lazy var tableView:UITableView = {
        let v = UITableView.init(frame: self.view.bounds, style: .plain)
        v.delegate = self.viewModel.viewProxy
        v.dataSource = self.viewModel.viewProxy
        v.register(SkuTopViewItemCell.self, forCellReuseIdentifier: "SkuTopViewItemCell")
        v.register(SkuItemCell.self, forCellReuseIdentifier: "SkuItemCell")
        v.register(SkuModeItemCell.self, forCellReuseIdentifier: "SkuModeItemCell")
        v.register(SkuModeSectionHeader.self, forHeaderFooterViewReuseIdentifier: "SkuModeSectionHeader")
        v.register(SkuMusicModeViewCell.self, forCellReuseIdentifier: "SkuMusicModeViewCell")
        v.register(SkuColorModeViewCell.self, forCellReuseIdentifier: "SkuColorModeViewCell")
        
        if #available(iOS 15.0, *) {
            v.sectionHeaderTopPadding = 0
        }
        return v
    }()
    
    lazy var viewModel:ATTableDemoViewModel = {
        let vm = ATTableDemoViewModel.init()
        vm.delegate = self
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        
        self.viewModel.loadData()
    }
}

extension ATTableDemoViewController: ATTableListVMDelegate{
    func didChangeState(_ state: ATListState, msg: String?, error: Error?) {
        self.tableView.reloadData()
    }
}
