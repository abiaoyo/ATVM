//
//  ATCollectionListVM.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

public protocol ATCollectionListVMDelegate: NSObjectProtocol,ATListVMStateDelegate {
    
}

open class ATCollectionListVM {

    public weak var delegate:ATCollectionListVMDelegate?
    public private(set) var viewProxy:ATCollectionViewProxy!
    public private(set) var state:ATListState = []
    
    public init(viewProxy:ATCollectionViewProxy) {
        self.viewProxy = viewProxy
        self.setupData()
    }
    
    public init() {
        self.viewProxy = ATCollectionViewProxy.init()
        self.setupData()
    }
    
    deinit {
        #if DEBUG
        print("deinit \(self)")
        #endif
    }
    
    open func setupData(){
        
    }
    
    public func changeState(_ state:ATListState, msg:String?, error:Error?){
        self.state = state
        self.delegate?.didChangeState(state, msg: msg, error: error)
    }
    
    
}
