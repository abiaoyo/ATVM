//
//  ATCollectionDemoViewModel.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/2.
//

import UIKit
import ATVM

class ATCollectionDemoViewModel: ATCollectionListVM {

    func loadData() {
        self.viewProxy.defaultSectionVM.itemVMs.removeAll()
        
        var itemVM = ATCollectionItemVM.init()
        itemVM.cellIdentifier = "TestCollectionItemCell"
        itemVM.cellSize = CGSize.init(width: UIScreen.main.bounds.width, height: 60)
        itemVM.dataContainer.value = "1234567890,229eu29r339r834203"
        self.viewProxy.defaultSectionVM.itemVMs.append(itemVM)
        
        itemVM = ATCollectionItemVM.init()
        itemVM.cellIdentifier = "TestCollectionItemCell"
        itemVM.cellSize = CGSize.init(width: UIScreen.main.bounds.width, height: 120)
        itemVM.dataContainer.value = "ABCDEFG, HIJKLMN"
        itemVM.didSelectItemHandler = { collectionView, indexPath, itemVM in
            if let _itemVM:ATCollectionItemVM = itemVM as? ATCollectionItemVM {
                _itemVM.dataContainer.value = "WFSDF"
            }
            itemVM.reloadViewHandler?()
        }
        self.viewProxy.defaultSectionVM.itemVMs.append(itemVM)
        
        self.delegate?.didChangeState([.query,.success], msg: nil, error: nil)
    }
    
}
