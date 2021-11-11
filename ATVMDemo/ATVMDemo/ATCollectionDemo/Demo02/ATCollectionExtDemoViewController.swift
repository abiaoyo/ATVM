//
//  ATCollectionExtDemoViewController.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/2.
//

import UIKit
import ATVM

class ATC_SectionVM: ATCollectionSectionVM{
    var backgroundColor = UIColor.orange
    
}

struct ATC_Item: ATCollectionVMExt{
    var atCollectionExt: ATCollectionVMExtContainer = ATCollectionVMExtContainer.init()
    
    func createAtCollectionExtLayout() {
        self.atCollectionExt.collectionItemVM = ATCollectionItemVM.init()
        self.atCollectionExt.collectionItemVM?.cellIdentifier = "ATCollectionExtItemCell"
        self.atCollectionExt.collectionItemVM?.cellSize = CGSize.init(width: UIScreen.main.bounds.width, height: 100)
    }
}

struct ATC_Group: ATCollectionVMExt{
    
    var items = Array<ATC_Item>.init()
    
    var atCollectionExt: ATCollectionVMExtContainer = ATCollectionVMExtContainer.init()
    func createAtCollectionExtLayout() {
        self.atCollectionExt.collectionSectionVM = ATC_SectionVM.init()
        self.atCollectionExt.collectionSectionVM?.headerIdentifier = "ATC_CollectionHeader"
    }
}

class ATC_CollectionHeader: ATCollectionReusableView{
    override func refreshSubviews(_ fromVM: Bool) {
        if let sectionVM:ATC_SectionVM = self.sectionVM as? ATC_SectionVM{
            self.backgroundColor = sectionVM.backgroundColor
        }
    }
}

class ATCollectionExtDemoViewController: UIViewController {

    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        
        let v = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        v.delegate = self
        v.dataSource = self
        v.register(ATCollectionExtItemCell.self, forCellWithReuseIdentifier: "ATCollectionExtItemCell")
        v.register(ATC_CollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ATC_CollectionHeader")
        return v
    }()
    
    lazy var dataArray = Array<ATC_Group>.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var group = ATC_Group.init()
        group.createAtCollectionExtLayout()
        group.atCollectionExt.collectionSectionVM?.headerSize = CGSize.init(width: UIScreen.main.bounds.width, height: 30)
        
        
        var item = ATC_Item.init()
        item.createAtCollectionExtLayout()
        item.atCollectionExt.collectionItemVM?.dataContainer.value = "QOJWEOFIJWFJOFIRJFOISF"
        group.items.append(item)
        
        self.dataArray.append(group)
        
        group = ATC_Group.init()
        group.createAtCollectionExtLayout()
        group.atCollectionExt.collectionSectionVM?.headerSize = CGSize.init(width: UIScreen.main.bounds.width, height: 20)

        item = ATC_Item.init()
        item.createAtCollectionExtLayout()
        item.atCollectionExt.collectionItemVM?.dataContainer.value = "239SAFKS 23938 asfj120@#kjwef IHSF"
        group.items.append(item)
        
        self.dataArray.append(group)
        
        self.view.addSubview(self.collectionView)
    }

}


extension ATCollectionExtDemoViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell:ATCollectionExtItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ATCollectionExtItemCell", for: indexPath) as? ATCollectionExtItemCell {
            cell.config(itemVM: self.dataArray[indexPath.section].items[indexPath.item].atCollectionExt.collectionItemVM!, indexPath: indexPath)
            return cell
        }
        return UICollectionViewCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.dataArray[section].atCollectionExt.collectionSectionVM!.headerSize
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionVM:ATC_SectionVM = self.dataArray[indexPath.section].atCollectionExt.collectionSectionVM as! ATC_SectionVM
        
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerIdentifier:String = sectionVM.headerIdentifier {
                if let header:ATCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as? ATCollectionReusableView {
                    header.config(sectionVM: sectionVM, indexPath: indexPath)
                    return header
                }
            }
        }
        return UICollectionReusableView.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.dataArray[indexPath.section].items[indexPath.row].atCollectionExt.collectionItemVM!.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionVM:ATC_SectionVM = self.dataArray[indexPath.section].atCollectionExt.collectionSectionVM as! ATC_SectionVM
        sectionVM.backgroundColor = UIColor.random
        sectionVM.reloadViewHandler?()
    }
}
