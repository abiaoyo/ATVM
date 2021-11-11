//
//  ViewController.swift
//  ATVMDemo
//
//  Created by abiaoyo on 2021/11/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = Array<String>.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        self.dataArray = [
                          "TableDemo",
                          "TableExtDemo",
                          "TableExt2Demo",
                          "ATTableDemo",
                          "CollectionDemo",
                          "CollectionExtDemo"]
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = self.dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.dataArray[indexPath.row] {
        case "TableDemo":
            let vctl = TableDemoViewController.init()
            self.navigationController?.pushViewController(vctl, animated: true)
            break
        case "TableExtDemo":
            let vctl = TableExtDemoViewController.init()
            self.navigationController?.pushViewController(vctl, animated: true)
            break
        case "TableExt2Demo":
            let vctl = TableExt2DemoViewController.init()
            self.navigationController?.pushViewController(vctl, animated: true)
            break
        case "ATTableDemo":
            let vctl = ATTableDemoViewController.init()
            self.navigationController?.pushViewController(vctl, animated: true)
            break
        case "CollectionDemo":
            let vctl = ATCollectionDemoViewController.init()
            self.navigationController?.pushViewController(vctl, animated: true)
            break
        case "CollectionExtDemo":
            let vctl = ATCollectionExtDemoViewController.init()
            self.navigationController?.pushViewController(vctl, animated: true)
            break
            
        default:
            break
        }
    }
}
