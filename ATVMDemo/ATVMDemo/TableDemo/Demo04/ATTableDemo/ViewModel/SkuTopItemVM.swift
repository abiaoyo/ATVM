//
//  SkuTopItemVM.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

typealias SwitchClick = (_ on:Bool) -> Void

class SkuTopItemVM: ATTableRowVM {
    
    lazy var backgroundColor:UIColor = UIColor.orange
    var switchClick:SwitchClick?
    override func createLayout() {
        self.cellHeight = 200
        self.cellIdentifier = "SkuTopViewItemCell"
    }
}
