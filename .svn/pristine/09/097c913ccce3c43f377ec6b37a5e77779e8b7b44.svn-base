//
//  RWDate.swift
//  RWDate
//
//  Created by mynSoo on 2018/1/14.
//  Copyright © 2018年 mynSoo. All rights reserved.
//

import Foundation

let _instacne: RWDate = RWDate();

class RWDate {
    
    // cache
    var formatterDict:Dictionary = Dictionary<String,DateFormatter>();
    var formatterList:Array = Array<String>();
    var cacheMaxCount:Int = 5 // default

    class func share() -> RWDate {
        return _instacne;
    }
    
    // 创建 formatter
    func creatFormatter(format: String)  -> DateFormatter {

        let formatter = DateFormatter();
        formatter.dateFormat = format;
        
        // 在容器存放
        formatterDict[format] = formatter;
        formatterList.append(format);
        
        print(formatterDict,formatterList);
        return formatter;
    }
    
    // 释放 formatter cache
    
    func clearCaches() {
        formatterDict.removeAll();
        formatterList.removeAll();
    }
    
    func dropFirstFormatter() {
        
        if let key = formatterList.first {
            formatterDict[key] = nil;
            formatterList.removeFirst();
        }
    }
    
    // 获取 formatter
    func loadFormatter(format: String) -> DateFormatter {
        
        if let formatter = formatterDict[format] {
            
            return formatter;
        }else {
            // 判断是否超过清理
            if(formatterList.count >= cacheMaxCount) {
                
                self.dropFirstFormatter();
            }
            
            let formatter = creatFormatter(format: format);
            return formatter
        }
    }
    
    // 转换
    func convertDateToString(toFormat: String, fromDate: Date) -> String? {
        
        let formatter = loadFormatter(format: toFormat);
        return formatter.string(from: fromDate);
    }
    
    func convertStringToDate(toFormat: String, fromString: String) -> Date? {
        
        let formatter = loadFormatter(format: toFormat);
        return formatter.date(from: fromString);
    }
}

extension String {
    
    func converToDate(toFormat: String) -> Date? {
        
        return _instacne.convertStringToDate(toFormat: toFormat, fromString: self);
    }
    
    func convertToString(fromFormat: String, toFormat: String) -> String? {
        
        if let fromDate = _instacne.convertStringToDate(toFormat: fromFormat, fromString: self) {
            
            return _instacne.convertDateToString(toFormat: toFormat, fromDate: fromDate);
        }else {
            
            return nil;
        }
    }
}

extension Date {
    
    func convertToString(toFormat: String) -> String? {
        
        return _instacne.convertDateToString(toFormat: toFormat, fromDate: self);
    }
}
