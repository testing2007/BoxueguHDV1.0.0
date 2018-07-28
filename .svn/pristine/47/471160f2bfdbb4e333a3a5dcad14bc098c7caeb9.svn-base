//
//  BXGConstrueReplayVC.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGConstrueReplayVC: UIViewController {
    
    var viewModel: BXGConstrueViewModel
    init(viewModel from: BXGConstrueViewModel) {
        viewModel = from
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var calendar: BXGConstrueReplayCalendarView = {
        let view = BXGConstrueReplayCalendarView()
        view.didSelectedClosure = { date in
            self.setSelectDate(date)
        }
        return view
    }()
    
    lazy var headerView: BXGConstrueReplayHeaderView = {
        let view = BXGConstrueReplayHeaderView()
        return view
    }()
    
    lazy var listView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.hexColor(hex: 0xf5f5f5)
        view.separatorStyle = .none
        view.register(BXGConstrueLiveCell.self, forCellReuseIdentifier: BXGConstrueLiveCell.description())
        view.bxg_setHeaderRefreshBlock({
            self.loadData()
        })
        return view
    }()
    
    lazy var topSpView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xf5f5f5)
        return view
    }()
    
    lazy var bottomSpView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexColor(hex: 0xf5f5f5)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installUI()
    }
    func installUI() {
        view.addSubview(calendar)
        view.addSubview(headerView)
        view.addSubview(topSpView)
        view.addSubview(bottomSpView)
        
        topSpView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(10)
            make.left.right.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(topSpView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(64)
        }
        
        
        calendar.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(-1)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        headerView.setHeaderDate(date: Date())
        view.addSubview(listView)
        
        bottomSpView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
            make.top.equalTo(calendar.snp.bottom)
        }
        
        listView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bottomSpView.snp.bottom)
        }
        
    }
    
    func loadData() {
        viewModel.loadReplayList { (succeed, message) in
            self.listView.bxg_endHeaderRefresh()
            self.listView.reloadData()
        }
    }
    
    func setSelectDate(_ date: Date) {
        headerView.setHeaderDate(date: date)
        
        if let key = date.convertToString(toFormat: "yyyy-MM-dd"), let list = viewModel.replayModelsKeyList {
            if let index = list.index(of: key), listView.numberOfSections > index && listView.numberOfRows(inSection: index) > 0 {
                listView.scrollToRow(at: IndexPath(row: 0, section: index), at: UITableViewScrollPosition.top, animated: false)
            }
        }
    }
}

extension BXGConstrueReplayVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let keyList = viewModel.replayModelsKeyList, keyList.count > indexPath.section {
            let key = keyList[indexPath.section]
            if let modelsMap = viewModel.replayModelsMap, let models = modelsMap[key], models.count > indexPath.row {
                let model = models[indexPath.row]
                if let planId = model.id {
                    viewModel.requestReplayDetail(planId: planId) { (succeed, message, models) in
                        if let models = models, models.count > 0 {
                            let vc = BXGConstrueReplayPlayerVC(planModel: model, playerModels: models)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.replayModelsMap?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let keyList = viewModel.replayModelsKeyList, keyList.count > section {
            let key = keyList[section]
            if let modelsMap = viewModel.replayModelsMap, let models = modelsMap[key] {
                return models.count
            }
        }
        
        return 0
//        return viewModel.replayModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BXGConstrueLiveCell.description(), for: indexPath)
        
        if let cell = cell as? BXGConstrueLiveCell, let keyList = viewModel.replayModelsKeyList, keyList.count > indexPath.section {
            let key = keyList[indexPath.section]
            if let modelsMap = viewModel.replayModelsMap, let models = modelsMap[key], models.count > indexPath.row {
                let model = models[indexPath.row]
                cell.setDataWithDuration(model.duration as NSNumber?, teacher: model.teacher, onAir: model.onAir, name: model.name, isCallBack: model.isCallBack, recommend: model.recommend as NSNumber?, construeId: model.id as NSNumber?, endTime: model.endTime,startTime: model.startTime, subjectId: model.subjectId as NSNumber?, desc: model.desc, subjectName: model.subjectName, isJoin: model.isJoin, indexPath: indexPath)
            }
        }

        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let tableview = scrollView as? UITableView {
            
            if let indexPaths = tableview.indexPathsForVisibleRows,
                let firstIndexPath = indexPaths.first,
                let keyList = viewModel.replayModelsKeyList,
                keyList.count > firstIndexPath.section  {
                let key = keyList[firstIndexPath.section]
                if let date = key.converToDate(toFormat: "yyyy-MM-dd") {
                    calendar.setDate(date: date)
                }
            }
        }
    }
}

//- (void)setDate:(NSDate *)date {
//
//    _date = date;
//    if(_date) {
//        self.headerDateLabel.text = [_date converDateStringToFormat:@"yyyy年M月d日 EEEE"];
//
//
//        NSString *key = [date converDateStringToFormat:@"yyyy-MM-dd"];
//        if(self.keyForIndex[key]) {
//            NSNumber *i = self.keyForIndex[key];
//            NSLog(i.stringValue);
//            [self.contentView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i.integerValue] atScrollPosition:UITableViewScrollPositionTop animated:false];
//
//        }
//
//    }
//}



