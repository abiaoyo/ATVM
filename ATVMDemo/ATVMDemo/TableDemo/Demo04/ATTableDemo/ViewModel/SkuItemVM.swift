//
//  SkuItemVM.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

class SkuItemVM: ATTableRowVM {
    var icon:String?
    var title:String?
    
    var backgroundColor = UIColor.purple
    
    override func createLayout() {
        self.cellHeight = 60
        self.cellIdentifier = "SkuItemCell"
    }
}
