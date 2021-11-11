//
//  ATCollectionReusableView.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATCollectionReusableView: UICollectionReusableView, ATCollectionReusableViewI{
    
    public var sectionVM: ATCollectionSectionI?
    public var indexPath: IndexPath?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupData()
        self.setupSubviews()
        self.setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupData()
        self.setupSubviews()
        self.setupLayout()
    }
    
    open func setupData(){
        
    }
    
    open func setupSubviews(){
        
    }
    
    open func setupLayout(){
        
    }
     
    public func config(sectionVM: ATCollectionSectionI, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.configAndRefresh(sectionVM: sectionVM)
    }
    
    private func configAndRefresh(sectionVM: ATCollectionSectionI) -> Void{
        self.sectionVM?.reloadViewHandler = nil
        self.sectionVM = sectionVM
        self.sectionVM?.reloadViewHandler = { [weak self] in
            self?.refreshSubviews(true)
        }
        self.refreshSubviews(false)
        self.layoutIfNeeded()
    }
    
    open func refreshSubviews(_ fromVM: Bool) -> Void{
        
    }
}
