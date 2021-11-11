//
//  TestCollectionItemCell.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/2.
//

import UIKit
import ATVM

class TestCollectionItemCell: ATCollectionItemCell {
    
    lazy var titleLabel:UILabel = {
        let v = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: self.bounds.width, height: 40))
        return v
    }()
    
    override func setupSubviews() {
        self.contentView.backgroundColor = UIColor.random
        self.contentView.addSubview(self.titleLabel)
    }
    
    override func refreshSubviews(_ fromVM: Bool) {
        if let itemVM:ATCollectionItemI = self.itemVM {
            self.titleLabel.text = itemVM.dataContainer.value as? String
        }
    }
    
}
