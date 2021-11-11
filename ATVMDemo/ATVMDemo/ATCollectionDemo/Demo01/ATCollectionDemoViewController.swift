//
//  ATCollectionDemoViewController.swift
//  SwiftDemo
//
//  Created by abiaoyo on 2021/11/2.
//

import UIKit
import ATVM

class ATCollectionDemoViewController: UIViewController, ATCollectionListVMDelegate, UICollectionViewDelegate {
    func didChangeState(_ state: ATListState, msg: String?, error: Error?) {
        if state.contains([.query,.success]) {
            self.collectionView.reloadData()
        }
    }

    lazy var viewModel:ATCollectionDemoViewModel = {
        let vm = ATCollectionDemoViewModel.init()
        vm.delegate = self
        vm.viewProxy.forwarder = self
        return vm
    }()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        
        let v = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        v.delegate = self.viewModel.viewProxy
        v.dataSource = self.viewModel.viewProxy
        v.register(TestCollectionItemCell.self, forCellWithReuseIdentifier: "TestCollectionItemCell")
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.collectionView)
        self.viewModel.loadData()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay: section:\(indexPath.section)  item:\(indexPath.item)")
    }
}
