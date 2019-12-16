//
//  MaybeViewController.swift
//  RxSwiftBasic
//
//  Created by Yin on 2019/12/16.
//  Copyright © 2019 Yin. All rights reserved.
//

import UIKit

class MaybeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        codeText.text = """
                   /** 
                   * @Date: 2019/12/16 4:40 下午
                   * @Description:  Maybe要么发出一个元素 要么一个completed事件 要么产生一个error事件
                   * @Param:  num判断的数值
                   * @Author: jie 
                   * @return:  MaybeObservable序列
                   */
                   func MaybeObservables(num : Int) -> Maybe<String> {
                       return Maybe<String>.create { maybe in

                           if (num > 0) {
                               maybe(.success("验证通过"))
                           } else {
                               //maybe(.error())
                           }

                           return Disposables.create()
                       }
                   }
                   """

        MaybeObservables(num: 10).subscribe(
                onSuccess: { s in print(s) },
                onError: { error in print("error") },
                onCompleted: {
                    print("完成")
                }).disposed(by: disposeBag)
    }


    /** 
    * @Date: 2019/12/16 4:40 下午
    * @Description:  Maybe要么发出一个元素 要么一个completed事件 要么产生一个error事件
    * @Param:  num判断的数值
    * @Author: jie 
    * @return:  MaybeObservable序列
    */
    func MaybeObservables(num: Int) -> Maybe<String> {
        return Maybe<String>.create { maybe in

            if (num > 0) {
                maybe(.success("验证通过"))
            } else {
                //maybe(.error())
            }

            return Disposables.create()
        }
    }

}
