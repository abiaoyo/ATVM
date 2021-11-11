//
//  ATDataContainer.swift
//  ATVM
//
//  Created by abiaoyo
//

import Foundation

public struct ATDataContainer<T:AnyObject>{
    public weak var weakValue:T?
    public var value:Any?
}
