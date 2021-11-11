//
//  SkuItemCell.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit
import ATVM

class SkuItemCell: ATTableRowCell {

    lazy var iconImgView = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 40, height: 40))
    lazy var titleLabel = UILabel.init(frame: CGRect.init(x: self.iconImgView.frame.maxX+10, y: 10, width: 200, height: 40))
    
    override func setupSubviews() {
        self.contentView.addSubview(self.iconImgView)
        self.contentView.addSubview(self.titleLabel)
    }
    override func refreshSubviews(_ fromVM: Bool) {
        if let itemVM:SkuItemVM = self.rowVM as? SkuItemVM{
            self.contentView.backgroundColor = itemVM.backgroundColor
        }
    }
}
