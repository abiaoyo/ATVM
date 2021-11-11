//
//  ATTableRowVM.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATTableRowVM:ATTableRowI{
    
    public var cellHeight: CGFloat = 0.0
    
    public var cellIdentifier: String!
    
    public var didSelectRowHandler: ATTableRowDidSelectHandler?
    
    public var reloadViewHandler:ATViewReloadHandler?
    
    lazy public var dataContainer: ATDataContainer<AnyObject> = ATDataContainer<AnyObject>.init()
    
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
