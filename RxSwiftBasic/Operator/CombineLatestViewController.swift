//
// Created by Yin on 2019/12/20.
// Copyright (c) 2019 Yin. All rights reserved.
//

import Foundation
import UIKit

class CombineLatestViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "CombineLatest"

        CombineLatest()

        self.codeText.text = """
                             /**
                             * @Date: 2019/12/20 1:13 下午
                             * @Description: combineLatest操作等将多个Observable中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来
                             *               这些源Observable中任何一个元素，他都会发出一个元素（前提是，这些Observable曾经发出过元素）
                             * @Param: -
                             * @Author: jie
                             * @return: -
                             */
                             func CombineLatest() {

                                 let first = PublishSubject<String>()
                                 let second = PublishSubject<String>()

                                 Observable.combineLatest(first, second) {
                                     $0 + $1
                                 }.subscribe(onNext: {
                                     print($0)
                                 }).disposed(by: disposeBag)

                                 first.onNext("1")
                                 second.onNext("A")
                                 first.onNext("2")
                                 second.onNext("B")
                                 second.onNext("C")
                                 second.onNext("D")
                                 first.onNext("3")
                                 first.onNext("4")

                             输出：
                             1A
                             2A
                             2B
                             2C
                             2D
                             3D
                             4D
                             """
    }

    /**
    * @Date: 2019/12/20 1:13 下午
    * @Description: combineLatest操作等将多个Observable中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来
    *               这些源Observable中任何一个元素，他都会发出一个元素（前提是，这些Observable曾经发出过元素）
    * @Param: -
    * @Author: jie
    * @return: -
    */
    func CombineLatest() {

        let first = PublishSubject<String>()
        let second = PublishSubject<String>()

        Observable.combineLatest(first, second) {
            $0 + $1
        }.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)

        first.onNext("1")
        second.onNext("A")
        first.onNext("2")
        second.onNext("B")
        second.onNext("C")
        second.onNext("D")
        first.onNext("3")
        first.onNext("4")

    }
}
