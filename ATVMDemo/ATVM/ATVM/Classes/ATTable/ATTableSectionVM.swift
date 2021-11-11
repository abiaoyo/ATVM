//
//  ATTableSectionVM.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATTableSectionVM: ATTableSectionI{
    
    lazy public var rowVMs: Array<ATTableRowI> = Array<ATTableRowI>.init()
    
    public var headerIdentifier: String?
    
    public var footerIdentifier: String?
    
    public var headerHeight: CGFloat = 0.001
    
    public var footerHeight: CGFloat = 0.001
    
    public var didClickSectionHandler: ATTableSectionClickHandler?
    
    public var reloadViewHandler:ATViewReloadHandler?
    
    lazy public var dataContainer:ATDataContainer<AnyObject> = ATDataContainer<AnyObject>.init()
    
    open func createLayout() {
        
    }
    
    public init() {
        
    }
    
    deinit {
        #if DEBUG
        print("deinit \(self)")
        #endif
    }
}
