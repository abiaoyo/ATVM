//
//  SkuModeSectionVM.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

class SkuModeSectionVM: ATTableSectionVM {
    var title:String?
    var backgroundColor = UIColor.gray
    
    override func createLayout() {
        self.title = "根据声音自动变换颜色"
        self.headerHeight = 40
        self.headerIdentifier = "SkuModeSectionHeader"
    }
}
