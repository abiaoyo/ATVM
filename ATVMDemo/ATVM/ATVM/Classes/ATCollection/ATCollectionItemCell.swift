//
//  ATCollectionItemCell.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATCollectionItemCell: UICollectionViewCell, ATCollectionItemCellI{
    public var itemVM: ATCollectionItemI?
    public var indexPath: IndexPath?

    public func config(itemVM: ATCollectionItemI, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.configAndRefresh(itemVM: itemVM)
    }
    
    private func configAndRefresh(itemVM: ATCollectionItemI) -> Void{
        self.itemVM?.reloadViewHandler = nil
        self.itemVM = itemVM
        self.itemVM?.reloadViewHandler = { [weak self] in
            self?.refreshSubviews(true)
            self?.layoutIfNeeded()
        }
        self.refreshSubviews(false)
        self.layoutIfNeeded()
    }
    
    open func refreshSubviews(_ fromVM: Bool) -> Void{

    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupData()
        self.setupSubviews()
        self.setupLayout()
        self.setupOthers()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupData()
        self.setupSubviews()
        self.setupLayout()
        self.setupOthers()
    }
    
    deinit {
        #if DEBUG
        print("deinit \(self.classForCoder)")
        #endif
    }
    
    open func setupData(){
        
    }
    open func setupSubviews(){
        
    }
    open func setupLayout(){
        
    }
    open func setupOthers(){
        
    }
}
