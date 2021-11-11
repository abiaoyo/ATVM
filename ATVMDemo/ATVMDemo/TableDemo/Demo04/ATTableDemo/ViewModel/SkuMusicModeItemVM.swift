//
//  SkuMusicModeItemVM.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

class SkuMusicModeItemVM: ATTableRowVM {

    var backgroundColor = UIColor.orange
    
    override func createLayout() {
        self.cellIdentifier = "SkuMusicModeViewCell"
        self.cellHeight = 300
    }
    
}
