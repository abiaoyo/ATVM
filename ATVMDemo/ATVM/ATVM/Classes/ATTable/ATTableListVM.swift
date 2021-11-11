//
//  ATTableListVM.swift
//  ATVM
//
//  Created by abiaoyo
//

import Foundation

public protocol ATTableListVMDelegate: NSObjectProtocol,ATListVMStateDelegate {
    
}

open class ATTableListVM {
    public weak var delegate:ATTableListVMDelegate?
    public private(set) var viewProxy:ATTableViewProxy!
    public private(set) var state:ATListState = []
    
    public init(viewProxy:ATTableViewProxy) {
        self.viewProxy = viewProxy
        self.setupData()
    }
    
    public init() {
        self.viewProxy = ATTableViewProxy.init()
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
