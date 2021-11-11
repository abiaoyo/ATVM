//
//  ATCollectionViewProxy.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

open class ATCollectionViewProxy: NSObject {
    private var _defaultSectionVM:ATCollectionSectionVM?
    public var defaultSectionVM:ATCollectionSectionVM {
        get{
            if _defaultSectionVM == nil{
                _defaultSectionVM = ATCollectionSectionVM.init()
            }
            return _defaultSectionVM!
        }
        set{
            _defaultSectionVM = newValue
        }
    }
    lazy public var sectionVMs:Array<ATCollectionSectionI> = Array<ATCollectionSectionI>.init()
    public weak var forwarder: UICollectionViewDelegate?
    
    public func getSectionVM(_ section:Int) -> ATCollectionSectionI {
        if _defaultSectionVM == nil{
            return self.sectionVMs[section]
        }else{
            return self.defaultSectionVM
        }
    }
    
    public func getItemVM(section:Int, item:Int) -> ATCollectionItemI {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.itemVMs[item]
    }
    
    public func getItemVM(indexPath:IndexPath) -> ATCollectionItemI {
        return self.getItemVM(section: indexPath.section, item: indexPath.item)
    }
    
    deinit {
        #if DEBUG
        print("deinit \(self)")
        #endif
    }
}

extension ATCollectionViewProxy: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        if _defaultSectionVM == nil{
            return sectionVMs.count
        }else{
            return 1
        }
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getSectionVM(section).itemVMs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemVM = self.getItemVM(indexPath: indexPath)
        
        if let cell:(UICollectionViewCell & ATCollectionItemCellI) = collectionView.dequeueReusableCell(withReuseIdentifier: itemVM.cellIdentifier, for: indexPath) as? (UICollectionViewCell & ATCollectionItemCellI) {
            cell.config(itemVM: itemVM, indexPath: indexPath)
            return cell
        }else{
            return UICollectionViewCell.init()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionVM = self.getSectionVM(indexPath.section)
        
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerIdentifier:String = sectionVM.headerIdentifier {
                if let header:(UICollectionReusableView & ATCollectionReusableViewI) = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as? (UICollectionReusableView & ATCollectionReusableViewI){
                    header.config(sectionVM: sectionVM, indexPath: indexPath)
                    return header
                }
            }
        }else{
            if let footerIdentifier:String = sectionVM.footerIdentifier {
                if let footer:(UICollectionReusableView & ATCollectionReusableViewI) = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: footerIdentifier, for: indexPath) as? (UICollectionReusableView & ATCollectionReusableViewI){
                    footer.config(sectionVM: sectionVM, indexPath: indexPath)
                    return footer
                }
            }
        }
        return UICollectionReusableView.init()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemVM = self.getItemVM(indexPath: indexPath)
        return itemVM.cellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.headerSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.footerSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.sectionInset
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let sectionVM = self.getSectionVM(section)
        return sectionVM.minimumInteritemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemVM = self.getItemVM(indexPath: indexPath)
        if let handler:ATCollectionItemDidSelectHandler = itemVM.didSelectItemHandler {
            handler(collectionView,indexPath,itemVM)
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
