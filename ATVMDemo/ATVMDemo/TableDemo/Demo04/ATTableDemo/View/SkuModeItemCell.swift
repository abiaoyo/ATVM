//
//  SkuModeItemCell.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/1.
//

import UIKit


class SkuModeItemCell: SkuItemCell {

    lazy var musicModeButton:UIButton = {
        let v = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: 100, height: 40))
        v.addTarget(self, action: #selector(clickMusic), for: .touchUpInside)
        v.setTitle("Music", for: .normal)
        return v
    }()
    
    lazy var colorModeButton:UIButton = {
        let v = UIButton.init(frame: CGRect.init(x: 150, y: 10, width: 100, height: 40))
        v.addTarget(self, action: #selector(clickColor), for: .touchUpInside)
        v.setTitle("Color", for: .normal)
        return v
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        self.addSubview(self.musicModeButton)
        self.addSubview(self.colorModeButton)
    }
    
    @objc func clickMusic() {
        if let itemVM:SkuModeItemVM = self.rowVM as? SkuModeItemVM{
            itemVM.itemClick?(0)
        }
    }
    
    @objc func clickColor() {
        if let itemVM:SkuModeItemVM = self.rowVM as? SkuModeItemVM{
            itemVM.itemClick?(1)
        }
    }
    
}
