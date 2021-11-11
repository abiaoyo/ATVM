//
//  ATCollectionItemVM.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATCollectionItemVM: ATCollectionItemI {
    public var cellSize: CGSize = CGSize.zero
    
    public var cellIdentifier: String!
    
    public var didSelectItemHandler: ATCollectionItemDidSelectHandler?
    
    lazy public var dataContainer: ATDataContainer<AnyObject> = ATDataContainer<AnyObject>.init()
    
    public var reloadViewHandler: ATViewReloadHandler?
    
    public func createLayout() {
        
    }
    
    public init() {
        
    }
    
    deinit {
        #if DEBUG
        print("deinit \(self)")
        #endif
    }
}
