//
//  BXGConstrueLiveVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation
import ObjectMapper
extension BXGConstrueLiveVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.liveModels?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BXGConstrueLiveCell.description(), for: indexPath)
        if let cell = cell as? BXGConstrueLiveCell,let list = viewModel.liveModels, list.count > indexPath.row  {
            
            let model = list[indexPath.row]
            
            cell.setDataWithDuration(model.duration as NSNumber?, teacher: model.teacher, onAir: model.onAir, name: model.name, isCallBack: model.isCallBack, recommend: model.recommend as NSNumber?, construeId: model.id as NSNumber?, endTime: model.endTime,startTime: model.startTime, subjectId: model.subjectId as NSNumber?, desc: model.desc, subjectName: model.subjectName, isJoin: model.isJoin, indexPath: indexPath)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if let list = viewModel.liveModels, list.count > indexPath.row  {
            let model = list[indexPath.row]
            if let id = model.id {
                viewModel.requestLivePlanDetail(planId: id) { (succeed, message, detailModel, roomId) in
                    
                    if succeed == true, let detailModel = detailModel, let roomId = roomId {
                        let vc2 = BXGLiveRoomVC(viewModel:BXGLiveRoomViewModel(detailModel: detailModel, roomId: roomId))
                        self.navigationController?.pushViewController(vc2, animated: true)
                    }
                }
            }
        }
    }
}

class BXGConstrueLiveVC: UIViewController {
    
    var viewModel: BXGConstrueViewModel
    
    // MARK: UI
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        view.register(BXGConstrueLiveCell.self, forCellReuseIdentifier: BXGConstrueLiveCell.description())
        view.separatorStyle = .none
        view.bxg_setHeaderRefreshBlock({
            self.loadData()
        })
        return view
    }()
    
    // MARK: INIT
    
    init(viewModel from: BXGConstrueViewModel) {
        viewModel = from
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installUI()
        loadData()
    }
    
    func installUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
    func loadData() {
        viewModel.loadLiveList { (succeed, message) in
            self.tableView.bxg_endHeaderRefresh()
            self.tableView.reloadData()
        }
    }
}


