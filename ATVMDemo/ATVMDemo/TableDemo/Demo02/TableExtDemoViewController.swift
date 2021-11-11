//
//  TableExtDemoViewController.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/10/25.
//

import UIKit
import SnapKit
import ATVM

class Animal:ATTableVMExt {
    var name:String?
    var summary:String?
    
    init(name:String?,summary:String?) {
        self.name = name
        self.summary = summary
    }
    
    deinit {
        print("deinit \(self)")
    }
    
    var atTableExt: ATTableVMExtContainer = ATTableVMExtContainer.init()

    func createAtTableExtLayout() {
        let tableRowVM = ATTableRowVM.init()
        tableRowVM.dataContainer.weakValue = self
        let size = (self.summary! as NSString).boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width-20, height: 1000), options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [.font:UIFont.systemFont(ofSize: 15)], context: nil).size
        tableRowVM.cellHeight = 10+20+10+CGFloat(ceilf(Float(size.height)))+10
        tableRowVM.cellIdentifier = "AnimalCell"
        self.atTableExt.tableRowVM = tableRowVM
    }
}

class AnimalGroup:ATTableVMExt{
    var atTableExt: ATTableVMExtContainer = ATTableVMExtContainer.init()
    
    func createAtTableExtLayout() {
        let sectionVM = ATTableSectionVM.init()
        sectionVM.headerHeight = 20
        sectionVM.headerIdentifier = "AnimalHeader"
        sectionVM.dataContainer.weakValue = self
        self.atTableExt.tableSectionVM = sectionVM
    }
    
    var title:String?
    lazy var animals = Array<Animal>.init()
    init(title:String?) {
        self.title = title
    }
    deinit {
        print("deinit \(self)")
    }
}

class AnimalHeader:ATTableHeaderFooterView{
    lazy var titleLabel = UILabel.init()
    
    override func setupSubviews(){
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    override func refreshSubviews(_ fromVM: Bool) {
        if let group:AnimalGroup = self.sectionVM!.dataContainer.weakValue as? AnimalGroup {
            self.titleLabel.text = group.title
        }
    }
}

class AnimalCell:ATTableRowCell{
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
    override func refreshSubviews(_ fromVM: Bool) {
        if let model:Animal = self.rowVM?.dataContainer.weakValue as? Animal {
            self.nameLabel.text = model.name
            self.summaryLabel.text = model.summary
        }
    }
}

class TableExtDemoViewController: UIViewController {

    lazy var tableView:UITableView = {
        let v = UITableView.init(frame: self.view.bounds, style: .plain)
        v.delegate = self
        v.dataSource = self
        v.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        v.register(AnimalCell.self, forCellReuseIdentifier: "AnimalCell")
        v.register(AnimalHeader.self, forHeaderFooterViewReuseIdentifier: "AnimalHeader")
        if #available(iOS 15.0, *) {
            v.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        return v
    }()
    
    deinit {
        print("deinit \(self)")
    }
    
    lazy var groupArray = Array<AnimalGroup>.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        
        var group = AnimalGroup.init(title: "鸟")
        group.createAtTableExtLayout()
        self.groupArray.append(group)
        
        var animal = Animal.init(name: "燕子", summary: "OWEFJWOIEFJIWFHSIFHSIUDFHUSIFDHISDFHIWEFHWEFOWJEFOJ*(@#RHFINSKDFNIUBDWIUF skdfhsidfhwowjfwoefw ISEAFHiwfue ")
        animal.createAtTableExtLayout()
        group.animals.append(animal)
        
        animal = Animal.init(name: "喜鹊", summary: "owefiow wefiuwh3i9s sfkjnas ")
        animal.createAtTableExtLayout()
        group.animals.append(animal)
        
        
        group = AnimalGroup.init(title: "猫科")
        group.createAtTableExtLayout()
        self.groupArray.append(group)
        
        animal = Animal.init(name: "老虎", summary: "1209e 23r9ei weoifdjsf us weois foiwef92r wefo wf wf weofwfiwofwefw8 wefiewf98rwhedwf wfusfs wefiuhweif q923e8sfdjskvjnsddv sidfus fweifjwiofejwfw wfeiuwifuwefwhef sdkjosd")
        animal.createAtTableExtLayout()
        group.animals.append(animal)
    }
}

extension TableExtDemoViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.groupArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupArray[section].animals.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.groupArray[indexPath.section].animals[indexPath.row].atTableExt.tableRowVM!.cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnimalCell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! AnimalCell
        cell.config(rowVM: self.groupArray[indexPath.section].animals[indexPath.row].atTableExt.tableRowVM!, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = self.groupArray[section].atTableExt.tableSectionVM!.headerHeight
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView:AnimalHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AnimalHeader") as? AnimalHeader {
            headerView.config(sectionVM: self.groupArray[section].atTableExt.tableSectionVM!, section: section)
            return headerView
        }
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowVM = self.groupArray[indexPath.section].animals[indexPath.row].atTableExt.tableRowVM
        if let model:Animal = rowVM!.dataContainer.weakValue as? Animal {
            model.name = "QWDWFSDFSDF \(indexPath.row)"
            rowVM!.reloadViewHandler?()
        }
    }
}
