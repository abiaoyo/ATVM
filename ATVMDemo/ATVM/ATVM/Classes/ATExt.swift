//
//  ATExt.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

//MARK: - ATTableVMExt
public class ATTableVMExtContainer{
    public var tableRowVM:ATTableRowI?
    public var tableSectionVM:ATTableSectionI?
    public required init() {
    }
    deinit {
        #if DEBUG
        print("deinit \(self)")
        #endif
    }
}

public protocol ATTableVMExt{
    var atTableExt:ATTableVMExtContainer {get set}
    func createAtTableExtLayout()
}

//MARK: - ATCollectionVMExt
public class ATCollectionVMExtContainer{
    public var collectionItemVM:ATCollectionItemI?
    public var collectionSectionVM:ATCollectionSectionI?
    public required init() {
    }
    deinit {
        #if DEBUG
        print("deinit \(self)")
        #endif
    }
}

public protocol ATCollectionVMExt{
    var atCollectionExt:ATCollectionVMExtContainer {get set}
    func createAtCollectionExtLayout()
}
