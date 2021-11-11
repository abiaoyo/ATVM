//
//  TableExt2DemoViewController.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/10/25.
//

import UIKit
import SnapKit
import ATVM

class Dog: Animal{
    
}

class DogCell:ATTableRowCell{
    lazy var nameLabel:UILabel = {
        let v = UILabel.init()
        v.numberOfLines = 1
        v.font = UIFont.boldSystemFont(ofSize: 16)
        return v
    }()
    
    lazy var summaryLabel:UILabel = {
        let v = UILabel.init()
        v.numberOfLines = 0
        v.font = UIFont.systemFont(ofSize: 15)
        return v
    }()
    
    override func setupSubviews() {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.summaryLabel)
    }
    
    override func setupLayout() {
        self.nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        self.summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp_bottomMargin).offset(10)
            make.right.left.equalTo(self.nameLabel)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    override func refreshSubviews(_ isKVO: Bool) {
        if let model:Animal = self.rowVM?.dataContainer.value as? Animal {
            self.nameLabel.text = model.name
            self.summaryLabel.text = model.summary
        }
    }
}

class TableExt2ViewModel:ATTableListVM{
    
    
    func createHeight(text:String?) -> CGFloat{
        let _text:NSString = (text as NSString?) ?? ("" as NSString)
        let size = _text.boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width-20, height: 1000), options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [.font:UIFont.systemFont(ofSize: 15)], context: nil).size
        return (10+20+10+CGFloat(ceilf(Float(size.height)))+10)
    }
    
    func loadData(){
        var sectionVM = ATTableSectionVM.init()
        sectionVM.headerHeight = 10
        self.viewProxy.sectionVMs.append(sectionVM)
        
        var dog = Dog.init(name: "AAA", summary: "woefjwof w wefojweifoa sfoasjiofawofheigei aewifwf[qfpwkf afoasidfjesofi ahsjkfasfAOSDJOjf")
        
        var rowVM = ATTableRowVM.init()
        rowVM.dataContainer.value = dog
        rowVM.cellHeight = self.createHeight(text: dog.summary)
        rowVM.cellIdentifier = "DogCell"
        sectionVM.rowVMs.append(rowVM)

        
        sectionVM = ATTableSectionVM.init()
        sectionVM.headerHeight = 10
        self.viewProxy.sectionVMs.append(sectionVM)

        dog = Dog.init(name: "BBASFWEFWEF", summary: "239r WSEF93wr asfojasofjWIEFJO SEFJSFA @#(EjosfMMNAS")

        rowVM = ATTableRowVM.init()
        rowVM.dataContainer.value = dog
        rowVM.cellHeight = self.createHeight(text: dog.summary)
        rowVM.cellIdentifier = "DogCell"
        sectionVM.rowVMs.append(rowVM)

        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.changeState(ATListState.success, msg: nil, error: nil)
        }
    }
}

class TableExt2DemoViewController:UIViewController,ATTableListVMDelegate{
    
    lazy var viewModel:TableExt2ViewModel = {
        let vm = TableExt2ViewModel.init(viewProxy: ATTableViewProxy.init())
        vm.delegate = self
        return vm
    }()
    
    lazy var tableView:UITableView = {
        let v = UITableView.init(frame: self.view.bounds, style: .plain)
        v.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        v.register(DogCell.self, forCellReuseIdentifier: "DogCell")
        v.estimatedRowHeight = 0
        v.estimatedSectionFooterHeight = 0
        v.estimatedSectionHeaderHeight = 0
        v.delegate = self.viewModel.viewProxy
        v.dataSource = self.viewModel.viewProxy
        if #available(iOS 15.0, *) {
            v.sectionHeaderTopPadding = 0
        }
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.viewModel.loadData()
    }
    
    func didChangeState(_ state: ATListState, msg: String?, error: Error?) {
        self.tableView.reloadData()
    }
}
