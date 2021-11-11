//
//  SkuModeItemVM.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit

typealias SkuModeItemClick = (_ type:Int) -> Void

class SkuModeItemVM: SkuItemVM {

    var itemClick:SkuModeItemClick?
    
    override func createLayout() {
        self.cellHeight = 120
        self.cellIdentifier = "SkuModeItemCell"
        self.backgroundColor = UIColor.blue
    }
    
}
