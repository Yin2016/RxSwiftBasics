//
//  CompletableViewController.swift
//  RxSwiftBasic
//
//  Created by Yin on 2019/12/16.
//  Copyright © 2019 Yin. All rights reserved.
//

import UIKit

class CompletableViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        codeText.text = """
        /// Completable 要么只能产生一个Completed事件 要么只能产生一个erro事件
        /// - Parameter num: 验证的数值
        func CompletableObservables(num : Int) -> Completable {
            return Completable.create { completable in
                
                if (num > 0) {
                    completable(.completed)
                } else {
                }
                
                return Disposables.create{}
            }
        }
        """
        
        CompletableObservables(num : 123).subscribe(onCompleted : {
            print("验证通过")
        }, onError : { error in
            
        }).disposed(by: disposeBag)
    }
    
    
    /// Completable 要么只能产生一个Completed事件 要么产生一个erro事件
    /// - Parameter num: 验证的数值
    func CompletableObservables(num : Int) -> Completable {
        return Completable.create { completable in
            
            if (num > 0) {
                completable(.completed)
            } else {
            }
            
            return Disposables.create{}
        }
    }

}
