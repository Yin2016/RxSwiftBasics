//
//  GitHubSignupService.swift
//  RxSwiftBasic
//
//  Created by Yin on 2020/1/13.
//  Copyright © 2020 Yin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya


// 用户注册服务
class GitHubSignupService {
    
    // 密码最小位数
    let minPasswordCount = 5
    
    // 网络请求服务
    lazy var gitHubApi = {
        return MoyaProvider<GitHubApi>()
    }()
    
    // 验证用户名
    func validateUserName(_ userName : String) -> Observable<ValidationResults> {
        // 判断用户名是否为空
        if userName.isEmpty {
            return .just(.empty)
        }
        
        // 判断用户名是否只有数字和字母
        if userName.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(message: "用户名只能包含数字和字母"))
        }
        
        let publishSubject = PublishSubject<ValidationResults>()
        // 发起网络请求
        gitHubApi.request(.userNameAvailable(userName)) { (result) in
            switch result {
            case .success:
                publishSubject.onNext(.ok(message: "通过"))
            default:
                publishSubject.onNext(.failed(message: "不通过"))
                break
            }

            print("result = \(result.description)")
        }
        
        return publishSubject.asObserver()
    }
    
    // 验证密码
    func validatePassword(_ password : String) -> ValidationResults {
        
        let numberOfCharacters = password.count
        
        // 判断密码是否为空
        if numberOfCharacters == 0 {
            return .empty
        }
        
        // 判断密码位数
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码至少需要\(minPasswordCount)个字符")
        }
        
        // 返回验证成功结果
        return .ok(message: "密码有效")
        
    }
    
    // 验证二次输入的密码
    func validationRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResults {
        
        // 判断密码是否为空
        if repeatedPassword.count == 0 {
            return .empty
        }
        
        // 判断两次输入的密码是否一致
        if repeatedPassword == password {
            return .ok(message: "密码有效")
        } else {
            return .failed(message: "两次输入的密码不一致")
        }
        
    }
    
}
