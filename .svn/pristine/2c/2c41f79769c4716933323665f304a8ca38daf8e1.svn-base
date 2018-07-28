//
//  BXGSystemManager.swift
//  BoxueguHD
//
//  Created by ZhiQiang wei on 2018/7/22.
//  Copyright © 2018年 ZhiQiang wei. All rights reserved.
//

import Foundation

class BXGSystemManager {
    static func freeSizeInBytes() -> CUnsignedLongLong {
        do {
            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,. userDomainMask, true)
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: documentDirectoryPath.last!)
            return (systemAttributes[FileAttributeKey.systemFreeSize] as! NSNumber).uint64Value
        } catch {
            return 0
        }
    }
    
    static func totalSizeInBytes() -> CUnsignedLongLong {
        do {
            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,. userDomainMask, true)
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: documentDirectoryPath.last!)
            return (systemAttributes[FileAttributeKey.systemSize] as! NSNumber).uint64Value
        } catch {
            return 0
        }
    }
    
    static func totalSizeInString() -> String {
        return stringFromBytes(bytes:self.totalSizeInBytes())
    }
    
    static func freeSizeInString() -> String {
        return stringFromBytes(bytes:self.freeSizeInBytes())
    }

    private static func stringFromBytes(bytes:CUnsignedLongLong) -> String {
        var strBytes:String = String("");
        if(bytes>1024*1024*1024)
        {
            //GByte
            strBytes = strBytes.appendingFormat("%.1fGB", (Double)(bytes)/1024.0/1024.0/1024);
        }
        else if(bytes>1024*1024)
        {
            //MBytes
            strBytes = strBytes.appendingFormat("%.1fMB", (Double)(bytes)/1024.0/1024.0);
        }
        else if(bytes>1024)
        {
            //KBytes
            strBytes = strBytes.appendingFormat("%.1fKB", (Double)(bytes)/1024.0);
        }
        else
        {
            strBytes = strBytes.appendingFormat("%.1fB", (Double)(bytes)*1.0);
        }
        return strBytes;
    }

}
