//
//  SkuTopViewItemCell.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

class SkuTopViewItemCell: ATTableRowCell {

    lazy var onButton:UIButton = {
        let v = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: 100, height: 40))
        v.addTarget(self, action: #selector(clickOn), for: .touchUpInside)
        v.setTitle("on", for: .normal)
        return v
    }()
    
    lazy var offButton:UIButton = {
        let v = UIButton.init(frame: CGRect.init(x: 150, y: 10, width: 100, height: 40))
        v.addTarget(self, action: #selector(clickOff), for: .touchUpInside)
        v.setTitle("off", for: .normal)
        return v
    }()
    
    override func setupSubviews() {
        self.contentView.addSubview(self.onButton)
        self.contentView.addSubview(self.offButton)
    }
    
    override func refreshSubviews(_ fromVM: Bool) {
        if let rowVM:SkuTopItemVM = self.rowVM as? SkuTopItemVM {
            self.contentView.backgroundColor = rowVM.backgroundColor
        }
    }
    
    @objc func clickOn(){
        if let rowVM:SkuTopItemVM = self.rowVM as? SkuTopItemVM {
            rowVM.switchClick?(true)
        }
    }
    @objc func clickOff(){
        if let rowVM:SkuTopItemVM = self.rowVM as? SkuTopItemVM {
            rowVM.switchClick?(false)
        }
    }
    
}
