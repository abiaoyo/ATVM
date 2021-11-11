//
//  SkuBrightnessVM.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit

class SkuBrightnessVM: SkuItemVM {

    override func createLayout() {
        self.cellHeight = 60
        self.cellIdentifier = "SkuItemCell"
        self.backgroundColor = UIColor.yellow
    }
    
}
