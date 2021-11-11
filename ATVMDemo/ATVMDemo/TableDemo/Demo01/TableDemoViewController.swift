//
//  TableDemoViewController.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/10/25.
//

import UIKit
import SnapKit
import ATVM

class Person{
    var name:String?
    var summary:String?
    init(name:String?,summary:String?) {
        self.name = name
        self.summary = summary
    }
}

class PersonRowVM: ATTableRowVM{
    
    override func createLayout() {
        self.cellIdentifier = "PersonCell"
        
        let person:Person = self.dataContainer.value as! Person
        
        let size = (person.summary! as NSString).boundingRect(with: CGSize.init(width: UIScreen.main.bounds.width-20, height: 1000), options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: [.font:UIFont.systemFont(ofSize: 15)], context: nil).size
        self.cellHeight = 10+20+10+CGFloat(ceilf(Float(size.height)))+10
    }
}

class PersonCell:ATTableRowCell{
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
        if let model:Person = self.rowVM?.dataContainer.value as? Person {
            self.nameLabel.text = model.name
            self.summaryLabel.text = model.summary
        }
        
    }
}

class TableDemoViewController: UIViewController {

    lazy var tableView:UITableView = {
        let v = UITableView.init(frame: self.view.bounds, style: .plain)
        v.delegate = self
        v.dataSource = self
        v.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        v.register(PersonCell.self, forCellReuseIdentifier: "PersonCell")
        return v
    }()
    
    var dataArray = Array<ATTableRowVM>.init()
    
    deinit {
//        let value = ATChannel.wkDictionary.value(key: "A")
        print("deinit: \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(self.tableView)
        
        var person = Person.init(name: "sisl", summary: "OWEFJWOIEFJIWFHSIFHSIUDFHUSIFDHISDFHIWEFHWEFOWJEFOJ*(@#RHFINSKDFNIUBDWIUF skdfhsidfhwowjfwoefw ISEAFHiwfue ")
        
        var rowVM = PersonRowVM.init()
        rowVM.dataContainer.value = person
        rowVM.createLayout()
        self.dataArray.append(rowVM)
        
        person = Person.init(name: "WOEJFoiwfsdfkjsndf", summary: "owefiow wefiuwh3i9s sfkjnas ")
        
        rowVM = PersonRowVM.init()
        rowVM.dataContainer.value = person
        rowVM.createLayout()
        self.dataArray.append(rowVM)
        
        person = Person.init(name: "woeidw 2387ey sdjfhbsdf weiud", summary: "1209e 23r9ei weoifdjsf us weois foiwef92r wefo wf wf weofwfiwofwefw8 wefiewf98rwhedwf wfusfs wefiuhweif q923e8sfdjskvjnsddv sidfus fweifjwiofejwfw wfeiuwifuwefwhef sdkjosd")
        
        rowVM = PersonRowVM.init()
        rowVM.dataContainer.value = person
        rowVM.createLayout()
        self.dataArray.append(rowVM)
    }
}

extension TableDemoViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.dataArray[indexPath.row].cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell:PersonCell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonCell {
            cell.config(rowVM: self.dataArray[indexPath.row], indexPath: indexPath)
            return cell
        }
        return UITableViewCell.init()
    }
}
