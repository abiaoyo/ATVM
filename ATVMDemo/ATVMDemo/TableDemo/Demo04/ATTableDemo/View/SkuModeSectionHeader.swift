//
//  SkuModeSectionHeader.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

class SkuModeSectionHeader: ATTableHeaderFooterView{

    lazy var titleLabel = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: 200, height: 20))
    
    override func setupSubviews() {
        self.contentView.addSubview(self.titleLabel)
    }
    
    override func refreshSubviews(_ fromVM: Bool) {
        if let sectionVM:SkuModeSectionVM = self.sectionVM as? SkuModeSectionVM {
            self.contentView.backgroundColor = sectionVM.backgroundColor
            self.titleLabel.text = sectionVM.title
        }
    }

}
