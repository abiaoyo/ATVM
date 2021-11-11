//
//  ATDefine.swift
//  ATVM
//
//  Created by abiaoyo
//

import UIKit

public struct ATListState: OptionSet {
    public static let idl = ATListState(rawValue: 1)
    public static let add = ATListState(rawValue: 1 << 1)
    public static let delete = ATListState(rawValue: 1 << 2)
    public static let update = ATListState(rawValue: 1 << 3)
    public static let query = ATListState(rawValue: 1 << 4)
    public static let success = ATListState(rawValue: 1 << 5)
    public static let failure = ATListState(rawValue: 1 << 6)
    public static let error = ATListState(rawValue: 1 << 7)
    public static let empty = ATListState(rawValue: 1 << 8)
    public static let noNetwork = ATListState(rawValue: 1 << 9)
    public static let reload = ATListState(rawValue: 1 << 10)
    public static let load = ATListState(rawValue: 1 << 11)
    public static let noData = ATListState(rawValue: 1 << 12)
    
    public let rawValue: Int8
    
    public init(rawValue: Int8) {
        self.rawValue = rawValue
    }
}



//MARK: - ViewModelI
public typealias ATViewReloadHandler = () -> Void
public protocol ATViewModelI{
    var dataContainer:ATDataContainer<AnyObject> {get set}
    var reloadViewHandler:ATViewReloadHandler? {get set}
    func createLayout() -> Void
}

//MARK: - TableVMI
public typealias ATTableRowDidSelectHandler = (_ tableView:UITableView, _ indexPath:IndexPath, _ rowVM:ATViewModelI) -> Void
public protocol ATTableRowI:(AnyObject & ATViewModelI){
    var cellHeight:CGFloat {get set}
    var cellIdentifier:String! {get set}
    var didSelectRowHandler:ATTableRowDidSelectHandler? {get set}
}

public typealias ATTableSectionClickHandler = (_ tableView:UITableView, _ section: Int, _ sectionVM:ATViewModelI) -> Void
public protocol ATTableSectionI:(AnyObject & ATViewModelI){
    var rowVMs:Array<ATTableRowI> {get set}
    var headerIdentifier:String? {get set}
    var footerIdentifier:String? {get set}
    var headerHeight:CGFloat {get set}
    var footerHeight:CGFloat {get set}
    var didClickSectionHandler:ATTableSectionClickHandler? {get}
}

//MARK: - UI ATTableRowCellI
public protocol ATTableRowCellI{
    var rowVM:ATTableRowI? {get set}
    var indexPath:IndexPath? {get set}
    func config(rowVM:ATTableRowI,indexPath:IndexPath) -> Void
}

//MARK: - UI ATTableHeaderFooterI
public protocol ATTableHeaderFooterI{
    var sectionVM:ATTableSectionI? {get set}
    var section:Int? {get set}
    func config(sectionVM:ATTableSectionI,section:Int) -> Void
}

//MARK - CollectionVMI
public typealias ATCollectionItemDidSelectHandler = (_ collectionView:UICollectionView, _ indexPath:IndexPath, _ itemVM:ATCollectionItemI) -> Void
public protocol ATCollectionItemI:(AnyObject & ATViewModelI) {
    var cellSize:CGSize {get set}
    var cellIdentifier:String! {get set}
    var didSelectItemHandler:ATCollectionItemDidSelectHandler? {get set}
}

public typealias ATCollectionSectionClickHandler = (_ collectionView:UICollectionView, _ section: Int, _ sectionVM:ATViewModelI) -> Void
public protocol ATCollectionSectionI:(AnyObject & ATViewModelI){
    var itemVMs:Array<ATCollectionItemI> {get set}
    var headerIdentifier:String? {get set}
    var footerIdentifier:String? {get set}
    var headerSize:CGSize {get set}
    var footerSize:CGSize {get set}
    var sectionInset:UIEdgeInsets {get set}
    var minimumLineSpacing:CGFloat {get set}
    var minimumInteritemSpacing:CGFloat {get set}
    var didClickSectionHandler:ATCollectionSectionClickHandler? {get}
}

//MARK: - UI ATCollectionItemCellI
public protocol ATCollectionItemCellI{
    var itemVM:ATCollectionItemI? {get set}
    var indexPath:IndexPath? {get set}
    func config(itemVM:ATCollectionItemI,indexPath:IndexPath) -> Void
}

//MARK: - UI ATCollectionReusableViewI
public protocol ATCollectionReusableViewI{
    var sectionVM:ATCollectionSectionI? {get set}
    var indexPath:IndexPath? {get set}
    func config(sectionVM:ATCollectionSectionI, indexPath:IndexPath) -> Void
}

//MARK: - ATListVMStateDelegate
public protocol ATListVMStateDelegate {
    func didChangeState(_ state:ATListState, msg:String?, error:Error?)
}
