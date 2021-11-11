//
//  ATCollectionSectionVM.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATCollectionSectionVM: ATCollectionSectionI {
    
    lazy public var itemVMs: Array<ATCollectionItemI> = Array<ATCollectionItemI>.init()
    
    public var headerIdentifier: String?
    
    public var footerIdentifier: String?
    
    public var headerSize: CGSize = CGSize.zero
    
    public var footerSize: CGSize = CGSize.zero
    
    public var sectionInset: UIEdgeInsets = UIEdgeInsets.zero
    
    public var minimumLineSpacing: CGFloat = 0.0
    
    public var minimumInteritemSpacing: CGFloat = 0.0
    
    public var didClickSectionHandler: ATCollectionSectionClickHandler?
    
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
