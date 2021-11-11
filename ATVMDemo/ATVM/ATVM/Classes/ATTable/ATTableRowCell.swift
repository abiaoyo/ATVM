//
//  ATTableRowCell.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATTableRowCell: UITableViewCell,ATTableRowCellI{
    public var rowVM: ATTableRowI?
    public var indexPath: IndexPath?

    public func config(rowVM: ATTableRowI, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.configAndRefresh(rowVM: rowVM)
    }
    
    private func configAndRefresh(rowVM: ATTableRowI) -> Void{
        self.rowVM?.reloadViewHandler = nil
        self.rowVM = rowVM
        self.rowVM?.reloadViewHandler = { [weak self] in
            self?.refreshSubviews(true)
            self?.layoutIfNeeded()
        }
        self.refreshSubviews(false)
        self.layoutIfNeeded()
    }
    
    open func refreshSubviews(_ fromVM: Bool) -> Void{

    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
