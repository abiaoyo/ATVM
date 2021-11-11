//
//  ATTableDemoViewModel.swift
//  SwiftDemo
//
//  Created by abiaoyo
//

import UIKit
import ATVM

class ATTableDemoViewModel: ATTableListVM {
    
    var on:Bool = true
    
    lazy var topSectionVM = ATTableSectionVM.init()
    
    lazy var itemSectionVM = ATTableSectionVM.init()
    
    lazy var modeSectionVM:SkuModeSectionVM = {
        let vm = SkuModeSectionVM.init()
        vm.createLayout()
        return vm
    }()
    
    lazy var musicModeVM:SkuMusicModeItemVM = {
        let vm = SkuMusicModeItemVM.init()
        vm.createLayout()
        return vm
    }()
    
    lazy var colorModeVM:SkuColorModeItemVM = {
        let vm = SkuColorModeItemVM.init()
        vm.createLayout()
        return vm
    }()
    
    lazy var topItemVM:SkuTopItemVM = {
        let vm = SkuTopItemVM.init()
        vm.createLayout()
        vm.switchClick = { [weak self] on in
            self?.on = on
            self?.loadData()
        }
        return vm
    }()
    
    lazy var lightEffectItemVM:SkuLightEffectsLibItemVM = {
        let vm = SkuLightEffectsLibItemVM.init()
        vm.createLayout()
        return vm
    }()
    
    lazy var timingVM:SkuTimingItemVM = {
        let vm = SkuTimingItemVM.init()
        vm.createLayout()
        return vm
    }()
    
    lazy var brightnessVM:SkuBrightnessVM = {
        let vm = SkuBrightnessVM.init()
        vm.createLayout()
        return vm
    }()
    
    lazy var modeVM:SkuModeItemVM = {
        let vm = SkuModeItemVM.init()
        vm.createLayout()
        vm.itemClick = { [weak self] type in
            
            if type == 0 {
                self?.modeSectionVM.rowVMs.removeAll()
                if let rowVM:ATTableRowI = self?.musicModeVM {
                    self?.modeSectionVM.rowVMs.append(rowVM)
                }
            }else if type == 1 {
                self?.modeSectionVM.rowVMs.removeAll()
                if let rowVM:ATTableRowI = self?.colorModeVM {
                    self?.modeSectionVM.rowVMs.append(rowVM)
                }
            }
            
            self?.delegate?.didChangeState(ATListState.reload, msg: nil, error: nil)
            
        }
        return vm
    }()
    
    
    func loadData(){
        self.topSectionVM.rowVMs.removeAll()
        self.itemSectionVM.rowVMs.removeAll()
        self.modeSectionVM.rowVMs.removeAll()
        self.viewProxy.sectionVMs.removeAll()
        
        self.viewProxy.sectionVMs.append(self.topSectionVM)
        self.topSectionVM.rowVMs.append(self.topItemVM)
        
        self.viewProxy.sectionVMs.append(self.itemSectionVM)
        self.itemSectionVM.rowVMs.append(self.lightEffectItemVM)
        self.itemSectionVM.rowVMs.append(self.timingVM)
        if self.on {
            self.itemSectionVM.rowVMs.append(self.brightnessVM)
            self.itemSectionVM.rowVMs.append(self.modeVM)
            
            self.viewProxy.sectionVMs.append(self.modeSectionVM)
            self.modeSectionVM.rowVMs.append(self.musicModeVM)
        }
        
        self.delegate?.didChangeState(ATListState.reload, msg: nil, error: nil)
    }
    
}
