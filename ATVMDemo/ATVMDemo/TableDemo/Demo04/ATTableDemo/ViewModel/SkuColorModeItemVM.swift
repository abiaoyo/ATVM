//
//  SkuColorModeItemVM.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

class SkuColorModeItemVM: ATTableRowVM {

    override func createLayout() {
        self.cellIdentifier = "SkuColorModeViewCell"
        self.cellHeight = 200
    }
    
}
