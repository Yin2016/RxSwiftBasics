//
//  gitHubAPI.swift
//  RxSwiftBasic
//
//  Created by Yin on 2020/1/10.
//  Copyright © 2020 Yin. All rights reserved.
//

import UIKit
import Moya

// 初始化GitHub请求的Provider
let GitHubProvider = MoyaProvider<GitHubApi>()

public enum GitHubApi {
    case userNameAvailable(String)
    case logIn
}

extension GitHubApi : TargetType {
    
    // 服务器地址
    public var baseURL: URL {
        switch self {
        case .userNameAvailable(_):
            return URL(string: "https://github.com")!
        case .logIn:
            return URL(string: "https://github.com")!
        }
    }
    
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .userNameAvailable(let userName):
            return userName
        case .logIn:
            return ""
        }
    }
    
    // 请求类型
    public var method: Moya.Method {
        return .get
    }
    
    // 请求任务事件
    public var task: Task {
        switch self {
        case .userNameAvailable(_):
            return .requestPlain
        case .logIn:
            return .requestPlain
        }
    }
        
    // 是否执行Alamofire验证
    public var validate : Bool {
        return false
    }
    
    // 单元测试模拟数据 只会在单元测文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    // 请求头
    public var headers: [String : String]? {
        return nil
    }
    
}
