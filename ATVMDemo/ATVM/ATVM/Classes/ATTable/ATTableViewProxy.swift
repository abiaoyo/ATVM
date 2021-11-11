//
//  ATTableViewProxy.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATTableViewProxy: NSObject{
    private var _defaultSectionVM:ATTableSectionVM?
    public var defaultSectionVM:ATTableSectionVM {
        get{
            if _defaultSectionVM == nil{
                _defaultSectionVM = ATTableSectionVM.init()
            }
            return _defaultSectionVM!
        }
        set{
            _defaultSectionVM = newValue
        }
    }
    lazy public var sectionVMs:Array<ATTableSectionI> = Array<ATTableSectionI>.init()
    public weak var forwarder: UITableViewDelegate?
    
    public func getSectionVM(_ section:Int) -> ATTableSectionI {
        if _defaultSectionVM == nil{
            return self.sectionVMs[section]
        }else{
            return self.defaultSectionVM
        }
    }
    
    public func getRowVM(section:Int, row:Int) -> ATTableRowI {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.rowVMs[row]
    }
    
    public func getRowVM(indexPath:IndexPath) -> ATTableRowI {
        return self.getRowVM(section: indexPath.section, row: indexPath.row)
    }
    
    deinit {
        #if DEBUG
        print("deinit \(self)")
        #endif
    }
}

extension ATTableViewProxy: UITableViewDelegate, UITableViewDataSource {
    
//MARK:UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        if _defaultSectionVM == nil{
            return sectionVMs.count
        }else{
            return 1
        }
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getSectionVM(section).rowVMs.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowVM = self.getRowVM(indexPath: indexPath)
        if let cell:ATTableRowCell = tableView.dequeueReusableCell(withIdentifier: rowVM.cellIdentifier!, for: indexPath) as? ATTableRowCell {
            cell.config(rowVM: rowVM, indexPath: indexPath)
            return cell
        }else{
            return UITableViewCell.init()
        }
    }
    
//MARK:UITableViewDelegate
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowVM = self.getRowVM(indexPath: indexPath)
        return rowVM.cellHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.headerHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.footerHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionVM = self.getSectionVM(section)
        if let headerIdentifier:String = sectionVM.headerIdentifier {
            if let header:(UITableViewHeaderFooterView & ATTableHeaderFooterI) = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as? (UITableViewHeaderFooterView & ATTableHeaderFooterI){
                header.config(sectionVM: sectionVM, section: section)
                return header
            }
        }
        let v = UIView.init()
        return v
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionVM = self.getSectionVM(section)
        if let footerIdentifier:String = sectionVM.footerIdentifier {
            if let footer:(UITableViewHeaderFooterView & ATTableHeaderFooterI) = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerIdentifier) as? (UITableViewHeaderFooterView & ATTableHeaderFooterI){
                footer.config(sectionVM: sectionVM, section: section)
                return footer
            }
        }
        let v = UIView.init()
        return v
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowVM = self.getRowVM(indexPath: indexPath)
        if let handler:ATTableRowDidSelectHandler = rowVM.didSelectRowHandler {
            handler(tableView,indexPath,rowVM)
        }
    }
    
    
    //转发
    open override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if self.forwarder?.responds(to: aSelector) == true {
            return self.forwarder
        }
        return nil
    }
    
    open override func responds(to aSelector: Selector!) -> Bool {
        if self.forwarder?.responds(to: aSelector) == true {
            return true
        }
        return super.responds(to: aSelector)
    }
}
