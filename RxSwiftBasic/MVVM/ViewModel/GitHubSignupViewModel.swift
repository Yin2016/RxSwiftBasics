//
//  GitHubSignupViewModel.swift
//  RxSwiftBasic
//
//  Created by Yin on 2020/1/13.
//  Copyright © 2020 Yin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GitHubSignupViewModel {
    // 用户名验证结果
    let validatedUserName : Driver<ValidationResults>
    
    // 密码验证结果
    let validatedPassword : Driver<ValidationResults>
    
    // 再次输入密码验证结果
    let validatedPasswordRepeated : Driver<ValidationResults>
    
    // 注册按钮是否可用
    let signupEnable : Driver<Bool>
    
    // 注册结果
//    let signResult : Driver<Bool>
    
    // 初始化ViewModel 根据输入实现对应的输出
    init(input : (userName : Driver<String>, password : Driver<String>, passwordRepeated : Driver<String>, loginTaps : Signal<Void>), dependency : (gitHubApi : GitHubApi, gitHubSignupService : GitHubSignupService)) {
        
        // 用户名验证
        validatedUserName = input.userName
            .flatMapLatest{userName in
                return dependency.gitHubSignupService.validateUserName(userName).asDriver(onErrorJustReturn: .failed(message: "服务器发生错误！"))
        }
        
        // 用户密码验证
        validatedPassword = input.password
            .map{ password in
                return dependency.gitHubSignupService.validatePassword(password)
        }
        
        // 重复输入密码验证
        validatedPasswordRepeated = Driver.combineLatest(input.password, input.passwordRepeated, resultSelector: dependency.gitHubSignupService.validationRepeatedPassword)
        
        // 注册按钮是否可用
        signupEnable = Driver.combineLatest(validatedUserName, validatedPassword, validatedPasswordRepeated) {(userName, password, repeatPassword) in
            userName.isValid && password.isValid && repeatPassword.isValid
        }.distinctUntilChanged()
        
//        // 获取最新的用户名和密码
//        let userNameAndPassword = Driver.combineLatest(input.userName, input.password) {
//            (username : $0, password : $1)
//        }
//
//        // 注册按钮点击结果
//        signResult = input.loginTaps.withLatestFrom(userNameAndPassword)
//            .flatMapLatest{ pair in
//                return dependency.gitHubSignupService.gitHubApi.request(.logIn) { (result) in
//
//                }
//        }
        
    }
}


