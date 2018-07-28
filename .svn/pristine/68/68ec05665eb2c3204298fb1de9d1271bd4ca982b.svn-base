//
//  BXGDownloadSelectViewModel.swift
//  BoxueguHD
//
//  Created by apple on 2018/7/19.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGDownloadSelectViewModel {
    var moduleModel : BXGCourseOutlineModuleModel
//    var courseName:String;
    var openHeadSectionIdSet:Set<Int>;//存放所有打开 SectionHeader 的记录集合
    var selItemsDictInSection:Dictionary<Int/*key=sectionId*/, Set<Int>/*value=itemsInSection*/>

    init(moduleModel: BXGCourseOutlineModuleModel) {
        self.openHeadSectionIdSet = Set<Int>()
        self.selItemsDictInSection = Dictionary<Int, Set<Int>>()

        self.moduleModel = moduleModel;
    }
    
    //select section
    func isOpenHeadSection(sectionId:Int) -> Bool {
        return openHeadSectionIdSet.contains(sectionId);
    }
    func addOpenHeadSectionId(sectionId:Int) -> Void {
        openHeadSectionIdSet.insert(sectionId);
    }
    func removeOpenHeadSectionId(sectionId:Int) -> Void {
        if(openHeadSectionIdSet.contains(sectionId)) {
            openHeadSectionIdSet.remove(sectionId);
        }
    }
    
    //select item in section
    func isSelItemCellInSection(cellId:Int, sectionId:Int) -> Bool {
        var bReturn:Bool = false
        if let itemsInSectionSet:Set<Int> = self.selItemsDictInSection[sectionId] {
            if(itemsInSectionSet.contains(cellId)) {
                bReturn = true
            }
        }
        return bReturn
    }
    func addSelItemCellInSection(cellId:Int, sectionId:Int) -> Void {
        if var itemsInSectionSet:Set<Int> = self.selItemsDictInSection[sectionId] {
            itemsInSectionSet.insert(cellId)
            self.selItemsDictInSection[sectionId] = itemsInSectionSet;
        } else {
            var selItemsInSection:Set<Int> = Set<Int>()
            selItemsInSection.insert(cellId)
            self.selItemsDictInSection[sectionId] = selItemsInSection
        }
    }
    func removeSelItemCellInSection(cellId:Int, sectionId:Int) -> Void {
        if (self.isSelItemCellInSection(cellId: cellId, sectionId: sectionId)) {
            var itemsInSectionSet:Set<Int> = self.selItemsDictInSection[sectionId]!
            itemsInSectionSet.remove(cellId)
            if(itemsInSectionSet.count == 0) {
                self.selItemsDictInSection[sectionId] = nil;
            } else {
                self.selItemsDictInSection[sectionId] = itemsInSectionSet;
            }
            self.selItemsDictInSection[sectionId] = itemsInSectionSet;
        }
    }
    
    
//    if (self.viewModel.isSelItemCellInSection(cellId:cell.identifier sectionId:cell.sectionId) {
//    self.viewModel.removeSelItemCellInSection(cellId:cell.identifier sectionId:cell.sectionId)
//    cell.bSel = false
//    } else {
//    self.viewModel.addSelItemCellInSection(cellId:cell.identifier sectionId:cell.sectionId)
//    cell.bSel = true
//    }
    
//            if var itemsInSectionSet:Set<Int> = self.selItemsDictInSection[cell.sectionId!] {
//                if(itemsInSectionSet.contains(cell.identifier!)) {
//                    itemsInSectionSet.remove(cell.identifier!)
//                    if(itemsInSectionSet.count == 0) {
//                        self.selItemsDictInSection[cell.sectionId!] = nil;
//                    } else {
//                        self.selItemsDictInSection[cell.sectionId!] = itemsInSectionSet;
//                    }
//                    cell.bSel = false
//                } else {
//                    itemsInSectionSet.insert(cell.identifier!)
//                    self.selItemsDictInSection[cell.sectionId!] = itemsInSectionSet;
//                    cell.bSel = true
//                }
//            } else {
//                var selItemsInSection:Set<Int> = Set<Int>()
//                selItemsInSection.insert(cell.identifier!)
//                self.selItemsDictInSection[cell.sectionId!] = selItemsInSection
//                cell.bSel = true;
//            }
    
    
}
