//
//  DLMFileUtil.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/12.
//

import Foundation

class DLMFileUtil {
    let manager = FileManager.default
    
    func readFile(at url: URL) -> [DLMProfileItem] {
        var fileInfoList: [DLMProfileItem] = []
        if let fileArray = manager.subpaths(atPath: url.path) {
            for fn in fileArray {
                print(fn)
                if !fn.hasSuffix("mobileprovision") {
                    continue
                }
                let fileURL = url.appending(path: fn)
                let plistContentStr = readFileTargetContent(fileURL: fileURL, startStr: "<?xml ", endStr: "</plist>")
                print(plistContentStr)
                
                // 读取到的内容转成字典
                if let data = plistContentStr.data(using: String.Encoding.ascii),
                   let plistDic = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String: Any]
                     {
//                print(plistDic)
                    let profileItem = DLMProfileItem.profileItem(from: plistDic)
                    fileInfoList.append(profileItem)
                }
            }
        }
        return fileInfoList
    }
    
    // 读取文件内容
    func readFileTargetContent(fileURL: URL, startStr: String, endStr: String) -> String {
        do {
            let string = try String(contentsOf: fileURL, encoding: .ascii)
            let startRange = string.range(of: startStr)
            let endRange = string.range(of: endStr)
            if let startRange = startRange, let endRange = endRange {
                let subStr = string[startRange.lowerBound..<endRange.upperBound]
                return String(subStr)
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    func removeFile(at fileURL: URL) {
        do {
            try manager.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
}
