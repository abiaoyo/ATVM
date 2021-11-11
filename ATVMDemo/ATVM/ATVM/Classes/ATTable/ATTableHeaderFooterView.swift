//
//  ATTableHeaderFooterView.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATTableHeaderFooterView: UITableViewHeaderFooterView, ATTableHeaderFooterI {
    
    public var sectionVM:ATTableSectionI?
    public var section:Int?
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
    
    
    public func config(sectionVM: ATTableSectionI, section: Int) {
        self.section = section
        self.configAndRefresh(sectionVM: sectionVM)
    }
    
    private func configAndRefresh(sectionVM: ATTableSectionI) -> Void{
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
