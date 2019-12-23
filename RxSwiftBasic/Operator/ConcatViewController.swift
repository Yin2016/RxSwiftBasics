//
// Created by Yin on 2019/12/20.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class ConcatViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Concat、ConcatMap"

        Concat()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.ConcatMap()
        }

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/20 1:57 下午
                             * @Description: concat操作符将多个Observable序列串联起来，当一个Observable元素发送完毕后，
                             *               后一个Observable才可以开始发出元素
                             *               如果前一个Observable未完成之前后一个Observable发出的所有元素都将被忽略
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func Concat() {

                                 let subject1 = BehaviorSubject(value: "🍅")
                                 let subject2 = BehaviorSubject(value: "🐶")

                                 subject1.concat(subject2)
                                         .subscribe {
                                             print($0)
                                         }
                                         .disposed(by: disposeBag)

                                 subject1.onNext("🍐")
                                 subject1.onNext("🍊")

                                 subject2.onNext("I would be ignored")
                                 subject2.onNext("🐱")
                                 subject1.onCompleted()
                                 subject2.onNext("🐭")
                                 
                             }

                             输出：
                             next(🍅)
                             next(🍐)
                             next(🍊)
                             next(🐱)
                             next(🐭)

                             ----------------------------------------
                             ----------------------------------------

                             /**
                             * @Date: 2019/12/20 4:25 下午
                             * @Description: ConcatMap操作符将源Observable的每一个元素应用一个转换方法，将他们转换成Observables
                             *               然后将这些Observables按顺序的发出元素，当前一个Observable元素发送完毕后，后一个Observable才开始发出元素
                             *               等待全一个Observable产生完成事件后，才对后一个Observable进行订阅
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func ConcatMap() {
                                 let subject1 = BehaviorSubject(value: "🍅")
                                 let subject2 = BehaviorSubject(value: "🐶")

                                 let variable = Variable(subject1)

                                 variable.asObservable()
                                         .concatMap {
                                             $0
                                         }
                                         .subscribe { s in
                                             print(s)
                                         }
                                         .disposed(by: disposeBag)

                                 subject1.onNext("🍐")
                                 subject1.onNext("🍊")

                                 variable.value = subject2

                                 subject2.onNext("I would be ignored")
                                 subject2.onNext("🐱")
                                 subject1.onCompleted()
                                 subject2.onNext("🐭")
                             }

                             输出：
                             next(🍅)
                             next(🍐)
                             next(🍊)
                             next(🐱)
                             next(🐭)
                             """
    }

    /**
    * @Date: 2019/12/20 1:57 下午
    * @Description: concat操作符将多个Observable序列串联起来，当一个Observable元素发送完毕后，
    *               后一个Observable才可以开始发出元素
    *               如果前一个Observable未完成之前后一个Observable发出的所有元素都将被忽略
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func Concat() {

        let subject1 = BehaviorSubject(value: "🍅")
        let subject2 = BehaviorSubject(value: "🐶")

        subject1.concat(subject2)
                .subscribe {
                    print($0)
                }
                .disposed(by: disposeBag)

        subject1.onNext("🍐")
        subject1.onNext("🍊")

        subject2.onNext("I would be ignored")
        subject2.onNext("🐱")
        subject1.onCompleted()
        subject2.onNext("🐭")

    }


    /**
    * @Date: 2019/12/20 4:25 下午
    * @Description: ConcatMap操作符将源Observable的每一个元素应用一个转换方法，将他们转换成Observables
    *               然后将这些Observables按顺序的发出元素，当前一个Observable元素发送完毕后，后一个Observable才开始发出元素
    *               等待全一个Observable产生完成事件后，才对后一个Observable进行订阅
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func ConcatMap() {
        let subject1 = BehaviorSubject(value: "🍅")
        let subject2 = BehaviorSubject(value: "🐶")

        let variable = Variable(subject1)

        variable.asObservable()
                .concatMap {
                    $0
                }
                .subscribe { s in
                    print(s)
                }
                .disposed(by: disposeBag)

        subject1.onNext("🍐")
        subject1.onNext("🍊")

        variable.value = subject2

        subject2.onNext("I would be ignored")
        subject2.onNext("🐱")
        subject1.onCompleted()
        subject2.onNext("🐭")
    }

}
