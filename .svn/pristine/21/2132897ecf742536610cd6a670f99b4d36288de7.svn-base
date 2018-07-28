//
//  BXGConstrueCalendarView.swift
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/24.
//  Copyright © 2018年 itcast. All rights reserved.
//

import Foundation

class BXGConstrueReplayCalendarView: UIView {
    var models: [BXGConstruePlanModel]?
    var eventCache: [String: BXGCalendarDateEvent]?
    
    var didSelectedClosure: ((_ date: Date)->())?
    var pageDidChangeClosure: ((_ date: Date)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        installUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    lazy var calendar: BXGCalendar = {
        let view = BXGCalendar.init(delegate: self)
        return view!
    }()
    
    // MARK: Setter
    
    func setDate(date: Date) {
        calendar.select(date)
    }
    
    func setModels(models: [BXGConstruePlanModel]?) {
        eventCache = nil
        self.models = models
        var map = [String: BXGCalendarDateEvent]()
        if let models = models {
            for model in models {
                
                if let createDate = model.createDate {
                    
                    if let hasPlan = model.hasPlan, hasPlan == 1 {
                        map[createDate] = BXGCalendarDateEvent.red

                    }else {
                        map[createDate] = BXGCalendarDateEvent.green
                    }
                }
            }
        }
        eventCache = map
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.calendar.reloadData()
        }
    }
    
    
    
    func installUI() {
        
//        addSubview(headerView)
//        headerView.addSubview(headerViewDateLb)
//        headerViewDateLb.snp.makeConstraints { (make) in
//            make.left.equalTo(15)
//            make.centerY.equalToSuperview()
//        }
//        headerView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.left.right.equalToSuperview()
//            make.height.equalTo(40)
//        }
        
        addSubview(calendar)
        calendar.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.bottom.right.equalToSuperview()
        }
        
        calendar.scope = .week;
    }
}

extension BXGConstrueReplayCalendarView: BXGCalendarDelegate {
    func minimumDate(for calendar: BXGCalendar!) -> Date! {
        if let first = models?.first,
            let dateString = first.startDate,
            let date = dateString.converToDate(toFormat: "yyyy-MM-dd") {
        
            return date
        }else {
            return nil
        }
    }
    
    func maximumDate(for calendar: BXGCalendar!) -> Date! {
        if let first = models?.first,
            let dateString = first.endDate,
            let date = dateString.converToDate(toFormat: "yyyy-MM-dd") {
            
            return date
        }else {
            return nil
        }
    }
    
    func calendarLessThanMinimumDate(_ calendar: BXGCalendar!) {
        BXGHUDTool.showHUD(string: "此前未开启直播计划")
    }
    
    func calendarLargerThanMaximumDate(_ calendar: BXGCalendar!) {
        // pass
    }
    
    func calendar(_ calendar: BXGCalendar!, eventFor date: Date!) -> BXGCalendarDateEvent {
        if let _ = models?.first,
            let dateString = date.convertToString(toFormat: "yyyy-MM-dd"),
            let eventCache = eventCache {
                return eventCache[dateString] ?? BXGCalendarDateEvent.none
        }else {
            return BXGCalendarDateEvent.none
        }
    }
    
    func calendar(_ calendar: BXGCalendar!, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.size.height)
        }
        UIView.animate(withDuration: 0.2) {
            if let superView = self.superview {
                superView.layoutIfNeeded()
            }
        }
    }
    
    func calendar(_ calendar: BXGCalendar!, didSelect date: Date!) {
        if let closure = didSelectedClosure {
            closure(date)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: BXGCalendar!) {
        if let closure = pageDidChangeClosure {
            closure(calendar.currentPage)
        }
    }
}
