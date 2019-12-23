//
//  SinglesViewController.swift
//  RxSwiftBasic
//
//  Created by Yin on 2019/12/13.
//  Copyright © 2019 Yin. All rights reserved.
//

import UIKit

class SingleViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SingleObservable(aa: 100).subscribe(onSuccess: { message in
            print(message)
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
        
        codeText.text = """
        /// Single是Observable的另一个版本 但是只能发出一个元素或者一个error事件
        /// 一般常用于http请求
        /// - Parameter aa: 验证数值
        func SingleObservable(aa : Int) -> Single<String> {
            return Single<String>.create {
                single in
                
                if aa > 100 {
                    single(.success("大于100"))
                } else{
                    single(.error(checkError.XiaoYu))
                }
                
                return Disposables.create {}
            }
        }
        """
    }
    
    /// Single是Observable的另一个版本 但是只能发出一个元素或者一个error事件
    /// 一般常用于http请求
    /// - Parameter aa: 验证数值
    func SingleObservable(aa : Int) -> Single<String> {
        return Single<String>.create {
            single in
            
            if aa > 100 {
                single(.success("大于100"))
            } else{
                single(.error(checkError.XiaoYu))
            }
            
            return Disposables.create {}
        }
    }
    
    enum checkError : Error {
        case XiaoYu
    }
    
    
}
