//
//  ValidationResult.swift
//  RxSwiftBasic
//
//  Created by Yin on 2020/1/13.
//  Copyright © 2020 Yin. All rights reserved.
//

import UIKit

/// 验证结果信息枚举
enum ValidationResults {
    case validating     // 正在验证中
    case empty          // 输入为空
    case ok(message : String)   // 验证通过
    case failed(message : String)   // 验证失败
}

/// 扩展ValidationResult 对应不同的验证结果返回验证是成功还是失败
extension ValidationResults {
    var isValid : Bool {
        switch self {
        case .ok(_):
            return true
        default:
            return false
        }
    }
}

/// 扩展ValidationResult 对应不同的验证结果返回不同的文字描述
extension ValidationResults : CustomStringConvertible {
    var description: String {
        switch self {
        case .validating:
            return "正在验证……"
        case .empty:
            return ""
        case let .ok(message):
            return message
        case let .failed(message):
            return message
        }
    }
    
}

/// 扩展ValidationResult 对应不同的验证结果返回不同的文字颜色
extension ValidationResults {
    var textColor : UIColor {
        switch self {
        case .validating:
            return .gray
        case .empty:
            return .black
        case .ok:
            return UIColor(red: 0/255, green: 130/255, blue: 0/255, alpha: 1)
        case .failed :
            return .red
        }
    }
    
}
